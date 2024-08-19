export ZSH="$XDG_DATA_HOME/omz"

ZSH_THEME="robbyrussell"
HYPHEN_INSENSITIVE="true"
HIST_STAMPS="mm/dd/yyyy"

plugins=(
  git
  zsh-syntax-highlighting
  zsh-autosuggestions
)

export ZSH_COMPDUMP=$ZSH/cache/.zcompdump-$HOST
export HISTFILE=$ZSH/cache/.history
source $ZSH/oh-my-zsh.sh

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

export PROMPT=' %/: '

source $HOME/.aliases

# nvm - nodejs version manager
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# sdkman - java version manager
export SDKMAN_DIR="$XDG_DATA_HOME/sdkman"
[[ -s "$XDG_DATA_HOME/sdkman/bin/sdkman-init.sh" ]] && source "$XDG_DATA_HOME/sdkman/bin/sdkman-init.sh"

# bun completions
[ -s "/home/careem/.local/bun/_bun" ] && source "/home/careem/.local/bun/_bun"
