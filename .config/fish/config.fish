set fish_greeting ""

#########################
# ALIASES               #
#########################
alias ll='ls -alhF'
alias la='ls -A'
alias l='ls -CF'
. ~/.config/fish/aliases.fish

#########################
# FUNCTIONS             #
#########################
# Manage AWS credentials
function aws-credentials
  if test -d ~/.aws
    rm ~/.aws;
  end
  ln -s .aws.$argv .aws
end

# Activate venv
function venv
  if type -q deactivate
    deactivate;
  end
  . ~/venv/$argv/bin/activate.fish
end

# Go to vilynx repo folder and activate venv
function repo
  if test -d ~/vilynx/repos/$argv
    cd ~/vilynx/repos/$argv;
    venv $argv
  else
    echo "Could'nt find repo $argv"
  end
end

# Clear postgresql cache
function clear_psql_cache
    sudo service postgresql stop
    echo 3 | sudo tee /proc/sys/vm/drop_caches
    sudo service postgresql start
end

# Install "minimal" python packages
function setup-python
    pip install autopep8 flake8 isort ipython pdbpp pip-tools pynvim
end

#########################
# THEME                 #
#########################
set -g fish_term24bit 1
set -g theme_color_scheme zenburn

#########################
# MISC                  #
#########################
set -x VIRTUAL_ENV_DISABLE_PROMPT 1

set -x PGHOST localhost
set -x PYENV_ROOT "$HOME/.pyenv"
set -x PATH "$PYENV_ROOT/bin" $PATH
