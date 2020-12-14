# Depends on PCS_ENVIRONMENT and PCS_SUBSTRATE env vars to pick a dyn codebuild job.
# If you supply a single arg, this will grep the job outputs and only include those that contain it. Useful for filtering on policy git URL, e.g.
# find-failed-pol-run dnr_log_collection
#
function find-failed-pol-run -d 'Looks through Dynamic Codebuild outputs for failed runs and outputs failure details'
  set SEARCH_HISTORY 100
  set -e JOB_GIT
  if test (count $argv) -gt 0
    set JOB_GIT $argv[1]
  end
  set CB_IDS (aws  codebuild list-builds --max-items $SEARCH_HISTORY | jq -r .ids[] | grep pac-codebuild-dynamic-codebuild-job-$PCS_SUBSTRATE-$PCS_ENVIRONMENT)
  set FAILED_RUNS (aws  codebuild batch-get-builds --ids $CB_IDS | jq -r '.builds[] | select (.buildStatus == "FAILED") | .id')
  if test (count $FAILED_RUNS) -eq 0
    echo "No failed runs in the last $SEARCH_HISTORY, it's your lucky day!"
    return
  end
  for run in $FAILED_RUNS
    set JOB (string split ':' $run)
    set JOB_OUTPUT (aws  logs get-log-events --log-group-name "/aws/codebuild/$JOB[1]" --log-stream-name $JOB[2] | jq -rj .events[].message | string join '\n')

    if set -q JOB_GIT
      echo -e $JOB_OUTPUT | grep -q "$JOB_GIT"
      if test $status -ne 0
        continue
      end
    end

    echo "******* $run ********"
    echo -e $JOB_OUTPUT | grep -A 1 'echo $accountID'
    echo -e $JOB_OUTPUT | grep -A 5 "Error applying plan"
    echo
  end

end

