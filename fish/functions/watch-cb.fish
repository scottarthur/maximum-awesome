function watch-cb
  if test (count $argv) = 1
    set CB $argv[1]
  else
    set CB (aws codebuild list-builds --max-items 1 | jq -r .ids[0])
  end
  set CB_JOB (echo $CB | cut -f 1 -d :)
  set CB_STR (echo $CB | cut -f 2 -d :)
  awslogs get -wSG --start='5 day' /aws/codebuild/$CB_JOB $CB_STR
  echo -e "\nOUTPUT FROM: $CB_JOB $CB_STR"
end

