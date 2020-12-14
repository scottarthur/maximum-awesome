# Depends on PCS_ENVIRONMENT and PCS_SUBSTRATE env vars to pick a dyn codebuild job.
# If you supply a single arg, this will grep the job outputs and only include those that contain it. Useful for filtering on policy git URL, e.g.
# find-failed-pol-run dnr_log_collection
#
function find-pol-run -d 'Looks through Dynamic Codebuild outputs for failed runs and outputs failure details'
  set -e JOB_GIT
  if test (count $argv) -gt 0
    set JOB_GIT $argv[1]
    echo "Finding executions of policy with $JOB_GIT in its git repo url"
  end
  set CB_IDS (aws codebuild list-builds --max-items 100 | jq -r .ids[] | grep pac-codebuild-dynamic-codebuild-job-$PCS_SUBSTRATE-$PCS_ENVIRONMENT)
  set MATCHING_RUNS (aws codebuild batch-get-builds --ids $CB_IDS | jq -r ".builds[] | select(.environment.environmentVariables[].value | contains(\"$JOB_GIT\")) | .id")
  for run in $MATCHING_RUNS
    set JOB (string split ':' $run)
    set JOB_OUTPUT (aws  logs get-log-events --log-group-name "/aws/codebuild/$JOB[1]" --log-stream-name $JOB[2] | jq -rj .events[].message | string join '\n')

    echo "******* $run ********"
    echo -e $JOB_OUTPUT | grep -A 1 'echo $accountID'
    echo -e $JOB_OUTPUT > $run
    echo
  end

end


