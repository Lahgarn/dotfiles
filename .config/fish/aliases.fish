# vim
alias vim="nvim"
alias vi="nvim"

# dotfiles
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# git aliases
alias gs='git status'
alias gd='git diff'
alias gdom='git diff origin/master'
alias gdomns='git diff origin/master --name-status'
alias ga='git add'
alias gall='git add --all'
alias gc='git commit'
alias gcm='git commit -m'
alias gcam='git commit -am'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gm='git merge'
alias gmom='git merge origin/master'
alias gstash='git stash'
alias gsl='git stash list'
alias gsp='git stash pop'
alias gg='git lgb'
alias gpull='git pull'
alias gpush='git push'

# Postgres connections
alias local_psql='psql -d vilynx-db -U vilynx-web'
alias test_psql='psql -h postgres2.test.east.vilynx.com -d vilynx-db -U vilynx-web -p 5432'
alias prod_psql='ssh -f vilynxro@apache71.prod.east.vilynx.com -L 5440:localhost:5433 sleep 600; psql -h localhost -p 5440 -d vilynx-db -U vilynx-web'

# Redshift connection
alias test_redshift='psql -h redshift.test.east.vilynx.com -d dagda_insights -p 5439 -U dagda_user'
alias prod_redshift='psql -h redshift.east.vilynx.com -d dagda_insights -p 5439 -U dagda_user'

alias kraken_psql='psql -h kraken.vpn.vilynx.com -d vilynx-db -U vilynx-web -p 5432'
