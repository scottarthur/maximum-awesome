# Usage: click the `Export` button on the staff access credentials page, and then immediately run this script.  It does the following:
# 1. Sets an env var (`AWS_CODECOMMIT_PROFILE` below) that determines what AWS profile from ~/.aws/config is used
# 2. Rewrites the last 3 lines of your ~/.aws/credentials file with the new credentials (be sure the creds you want to change are at the bottom of your current credential file!)
#
# requirements:  be on a mac, `brew install coreutils`
function ccgcp -d "Saves the Staff Access AWS keys in your clipboard to ~/.aws/credentials"
  # Don't continue unless clipboard has the creds export command in it
  if ! pbpaste | string match -r "export AWS_ACCESS_KEY_ID.*"
    echo "Clipboard didn't have credentials"
    return 1
  end
  eval (pbpaste)
  set -xg AWS_CODECOMMIT_PROFILE Terraform-GCP
  # remove last three lines of file (old creds)
  for i in (seq 3)
    sed -i '' -e '$ d' ~/.aws/credentials
  end
  # Grab new creds from env and append to creds file
  for line in (env | grep AWS | egrep "KEY|TOKEN")
    echo $line >> ~/.aws/credentials
  end
end
