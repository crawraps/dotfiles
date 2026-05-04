[ ! -d $CACHE ] && mkdir -p $CACHE
[ ! -f $CACHE/zprofile.log ] && touch $CACHE/zprofile.log

truncate -s 0 $CACHE/zprofile.log
Hyprland

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
