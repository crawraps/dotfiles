typeset -U path PATH

export ZVM_INIT_MODE='sourcing'
export XDG_SESSION_TYPE=wayland
export XDG_CURRENT_DESKTOP=Hyprland
export XDG_SESSION_DESKTOP=Hyprland
export QT_QPA_PLATFORM="wayland;xcb"
export GDK_BACKEND=wayland,x11

export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local
export WALLPAPERS=$HOME/Images/wallpapers
export CACHE=$HOME/.cache

export LESSHISTFILE=$CACHE/less/history
export NVM_DIR=$XDG_DATA_HOME/nvm
export FIREFOX_CHROME=$HOME/.mozilla/firefox/13gd5xvd.default-release/chrome

export OPENAI_API_KEY=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

path=($XDG_DATA_HOME/bin/ $path)

export PATH
