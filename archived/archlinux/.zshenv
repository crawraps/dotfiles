typeset -U path PATH

export ZVM_INIT_MODE='sourcing'
export XDG_SESSION_TYPE=wayland
export XDG_CURRENT_DESKTOP=Hyprland
export XDG_SESSION_DESKTOP=Hyprland
export QT_QPA_PLATFORM=wayland
export GDK_BACKEND=wayland

export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local
export WALLPAPERS=$HOME/Images/wallpapers
export CACHE=$HOME/.cache

export LESSHISTFILE=$CACHE/less/history
export NVM_DIR=$XDG_DATA_HOME/nvm

# bun
export BUN_INSTALL="$XDG_DATA_HOME/bun"

# android sdk
export ANDROID_HOME=$HOME/Android/Sdk
export path=($ANDROID_HOME/emulator $path)
export path=($ANDROID_HOME/platform-tools $path)

path=($XDG_DATA_HOME/bin/ $path)
path=($BUN_INSTALL/bin $path)
path=(/usr/lib $path)

export PATH

source $HOME/.tokens
