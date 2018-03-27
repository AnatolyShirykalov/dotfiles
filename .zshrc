export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"

export HISTSIZE=10000000
export SAVEHIST=$HISTSIZE

plugins=(rails git ruby archlinux systemd bundler zsh-syntax-highlighting command-not-found)


source $ZSH/oh-my-zsh.sh


# Распаковка архивов
# example: extract file
extract () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1        ;;
      *.tar.gz)    tar xzf $1     ;;
      *.bz2)       bunzip2 $1       ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1     ;;
      *.tar)       tar xf $1        ;;
      *.tbz2)      tar xjf $1      ;;
      *.tbz)       tar -xjvf $1    ;;
      *.tgz)       tar xzf $1       ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1  ;;
      *.7z)        7z x $1    ;;
      *)           echo "I don't know how to extract '$1'..." ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Запаковать архив
# example: pk tar file
pk () {
  if [ $1 ] ; then
    case $1 in
      tbz)       tar cjvf $2.tar.bz2 $2      ;;
      tgz)       tar czvf $2.tar.gz  $2       ;;
      tar)      tar cpvf $2.tar  $2       ;;
      bz2)    bzip $2 ;;
      gz)        gzip -c -9 -n $2 > $2.gz ;;
      zip)       zip -r $2.zip $2   ;;
      7z)        7z a $2.7z $2    ;;
      *)         echo "'$1' cannot be packed via pk()" ;;
    esac
 else
   echo "'$1' is not a valid file"
 fi
}

alias ls='ls --color=auto'

if [[ $(command -v chromium) != "" ]];    then alias -s {html,htm}=chromium; fi
if [[ $(command -v vlc) != "" ]];         then alias -s {avi,mpeg,mpg,mov,m2v,mp3,mp4}=vlc; fi
if [[ $(command -v libreoffice) != "" ]]; then alias -s {csv}=libreoffice; fi

if [[ $(command -v xclip) != "" ]]; then alias copy="xclip -selection clipboard -i"; fi
if [[ $(command -v git) != "" ]];   then alias ggl="git pull --rebase"; fi

if [[ $(command -v ruby) != "" ]]; then
  export GEM_PATH=$HOME/.gem/ruby/$(ruby --version | sed -E 's/^.*(([0-9]+\.){2})[0-9]+.*$/\10/')
  export GEM_HOME=$GEM_PATH
  export PATH=$GEM_PATH/bin:$PATH
  alias u="bundle exec unicorn -c unicorn.conf"
  if [[ $(ls /usr/share | grep chruby) != "" ]]; then
    source /usr/share/chruby/chruby.sh
  fi
fi

if [[ $(ls /usr/local | grep texlive) != "" ]]; then
  v=$(ls /usr/local/texlive | grep -E '^[0-9]{4}$' | sort | tail -n 1)
  export PATH=$HOME/bin:$GEM_PATH/bin:/usr/local/texlive/$v/bin/x86_64-linux:$PATH
  export MANPATH=/usr/local/texlive/$v/texmf-dist/doc/man:$MANPATH;
  export INFOPATH=/usr/local/texlive/$v/texmf-dist/doc/info:$INFOPATH;
fi

if [[ $(ls /opt | grep "android-sdk") != "" ]]; then
  export PATH=$PATH:/opt/android-sdk/tools:/opt/android-sdk/platform-tools:/opt/android-sdk/build-tools
fi

if [[ $(ls /opt | grep cocos2d) != "" ]]; then
  PATH=/opt/cocos2d-x/tools/cocos2d-console/bin:/opt/cocos2d-x/tools/cocos2d-console/plugins/plugin_package:$PATH
  export PATH
fi

if [[ $(command -v go) != "" ]]; then
  export GOPATH=$HOME/workspaces/go
  mkdir -p $GOPATH
  export GOBIN=$GOPATH/bin
fi

command_not_found_handler() {
  if [ -t 0 ]; then
    if [[ $(echo $1 | grep -E '^[^@]+@[^@]+') == "" ]]; then
      echo "$1: command not found";
    else
      ssh $1
    fi
  else
    grep $1;
  fi
}

ftrans() {
  mask=*
  if [[ $1 != "" ]]; then mask=$1; fi
  if [[ $(command -v trans) != "" ]]; then
    for f in $mask; do
      mv $f $(trans -f ru -t en $f -dump | jq ".[0] | .[0] | .[0]" | sed -E 's/"//g' | sed -E 's/ /_/g');
    done
  else
    echo "install trans package"
  fi
}
