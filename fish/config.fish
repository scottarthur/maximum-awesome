# vim mode
fish_vi_key_bindings

# use rvm
bass "source /Users/sarthur/.rvm/scripts/rvm"

# Editor stuff
alias vim=nvim
alias vi=nvim
alias v=nvim
set -x EDITOR /usr/local/bin/nvim

# Handy aliases
alias k=kubectl
alias g=git

# Color theme stuff
set -x theme_color_scheme solarized-light
#set -x theme_color_scheme solarized-dark

# psql stuff
set -x PGDATA /usr/local/var/postgres

# Go stuff
set -x GOPATH $HOME/go
set -x GOBIN $HOME/go/bin
set -x GO111MODULE on
set -x GOPRIVATE "github.com/sfdc-pcg,git.soma.salesforce.com"

# AWS Stuff
set -x AWS_DEFAULT_REGION us-west-2

# GCP stuff
set -x GOOGLE_CLOUD_KEYFILE_JSON ~/secrets/pcs-test-billing-3f0d6ccfa057.json
set -x GOOGLE_APPLICATION_CREDENTIALS $GOOGLE_CLOUD_KEYFILE_JSON

# PCS Stuff
set -x PCS_ENVIRONMENT staging
set -x PCS_SUBSTRATE aws
set -x PCS_METRICS console
set -x PCS_DEV_TOOLS_DIRECTORY "$HOME/dev/pcs-dev-tools"

# git signing needs this set
set -x GPG_TTY (tty)

# Set default (localhost) context for docker, kubernetes
docker context use default
kubectl config use-context docker-desktop
