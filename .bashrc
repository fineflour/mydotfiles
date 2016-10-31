#!export PATH="$HOME/.rbenv/bin:$PATH"

export EITOR='vim'

eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="/opt/android-studio/bin:$PATH"
export PATH="/root/Android/Sdk/platform-tools:$PATH"
export ANDROID_SDK="/root/Android/Sdk"
export ANDROID_NDK="/root/Android/android-ndk/android-ndk-r10e"
export PATH=${PATH}:${ANDROID_SDK}/tools


#export TERM="xterm-256color"
# ryan
#alias tmux="tmux -2"
function parse_git_branch () {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
 
RED="\[\033[0;31m\]"
YELLOW="\[\033[0;33m\]"
GREEN="\[\033[0;32m\]"
NO_COLOR="\[\033[0m\]"
 
PS1="$GREEN\u@\h$NO_COLOR:\w$YELLOW\$(parse_git_branch)$NO_COLOR\$ "



### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
