# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder


# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(git z zsh-autosuggestions zsh-syntax-highlighting kubectl helm github history-substring-search)
source $ZSH/oh-my-zsh.sh

# User configuration

export GOPATH="$HOME/go"
export GO111MODULE=auto
export GOROOT="$(brew --prefix golang)/libexec"
export PATH=$PATH:$(go env GOPATH)/bin

export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:~/bin
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/Applications/IntelliJ IDEA.app/Contents/MacOS:$PATH"

export JAVA_HOME=$(/usr/libexec/java_home)

alias k=kubectl

# Installed by brew
export STARSHIP_CONFIG=~/configurationFiles/conf/starship.toml
eval "$(starship init zsh)"

export PATH="/opt/homebrew/opt/openjdk@11/bin:$PATH"

alias ec="/Applications/Emacs.app/Contents/MacOS/bin/emacsclient --create-frame -t"
export TERM=xterm

export EDITOR="/Applications/Emacs.app/Contents/MacOS/bin/emacsclient -t"

