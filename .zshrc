# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export EDITOR="nvim"


# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME=""
ZSH_DISABLE_COMPFIX=true
# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable. HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

plugins=(git macos zsh-syntax-highlighting zsh-autosuggestions rust fzf brew thefuck zsh-interactive-cd zoxide) 

source $ZSH/oh-my-zsh.sh

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
fpath=($fpath "~/.zfunctions")


##### User Aliases and Functions
eval $(thefuck --alias)
# aliases 
alias shit="fuck"
alias startYabai="brew services start yabai"
alias stopYabai="brew services stop yabai"
alias songDL="sh ~/songDL.sh"
alias tree="tree -h --sort size --du"
alias bsr="brew services restart" 
alias ytdlmp3="yt-dlp --audio-format mp3 -x --external-downloader aria2c --external-downloader-args '-c -j 5 -x 10 --summary-interval=0'  -o \"%(title)s.%(ext)s\""
alias ytdl="yt-dlp -f mp4 --external-downloader aria2c --external-downloader-args '-c -j 5 -x 10 --summary-interval=0' -o \"%(title)s.%(ext)s\""
alias ls='lsd'
alias lt='lsd --tree'
alias reload="source $HOME/.zshrc"
alias cat='bat'
alias oo='open .'
alias wipe='~/wipe.sh'
alias unwipe='~/unwipe.sh'
alias python='python3'
alias cr='cargo run'
alias rmld='rm -rf $(1)'


# Java development 
export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_221.jdk"
# export JAVA_HOME="/opt/homebrew/opt/openjdk@17/"
function toggleJavaVers(){
    jh=$(env | grep JAVA_HOME | cut -d'=' -f 2)
    # echo $jh
    if [[ "$jh" == "/Library/Java/JavaVirtualMachines/jdk1.8.0_221.jdk" ]];then
        export JAVA_HOME="/opt/homebrew/opt/openjdk@17/"
    else
        export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_221.jdk"
    fi
    java -version
}
function jcr() {
    #swap=false
    #jh=$(env | grep JAVA_HOME | cut -d'=' -f 2)
    #if [[ "$jh" != "/Library/Java/JavaVirtualMachines/jdk1.8.0_221.jdk" ]]; then
    #    toggleJavaVers
    #    swap=true
    #fi
    r=$(echo $1 | cut -d'.' -f 1)
    javac $1 && java $r
    #if [ $swap = true ]; then
    #    toggleJavaVers
    #fi
}
function jcrd() {
    r=$(echo $1 | cut -d'.' -f 1)
    javac -cp ".:~/Developments/Java/libraries/gpdraw.jar" $1 && java -classpath ".:~/Developments/Java/libraries/gpdraw.jar" $r

}
function jcri(){
    r=$(echo $1 | cut -d'.' -f 1)
    javac -cp ".:~/Developments/Java/libraries/gpdraw.jar:$2" $1 && java -classpath ".:~/Developments/Java/libraries/gpdraw.jar:$2" $r
}
# Rust functions for development
function rcr(){
    f=$(echo $1 | cut -d'.' -f 1)
    rustc $1 && ./$f 
}
# Basic function using ffmpeg to bassBoost audiofiles
function bassBoost(){
    d=$(echo $1 | cut -d'.' -f 1)
    r=$(echo "$d" + "temp")
    ffmpeg -i "$1" -loglevel error -af "$filter64 $2 , $filter400 $3" "$r.mp3"
    rm "$1"
    mv "$r.mp3" "$1"
}
function vlength(){
  ffmpeg -i $1 2>&1 | grep Duration | cut -d ' ' -f 4 | sed s/,//
}
# Ease of life for pandoc because I cant be bothered to type all that
function pdc(){
  f=$(echo $1|cut -d'.' -f 1)
  pandoc $1 -o $f.pdf --pdf-engine=xelatex -V geometry:"left=25mm,right=25mm,top=10mm,bottom=25mm" -V fontsize=15pt -V monofont="Courier New" --include-in-header ~/Documents/header.tex --toc
  # pandoc -s --pdf-engine=xelatex --from=vimwiki --metadata-file=$HOME/vimwiki/basicMetadata.yaml "${@:2}" $1 -o $f.pdf
}

function copy(){
  cat $1 | pbcopy
}
function dls(){
  song=$(echo $(osascript -l JavaScript ~/Music/dev/getSong.js) )
  artist=$(osascript -l JavaScript ~/Music/dev/getArtist.js | tr -d '\r\n')
  full_name=$(echo "$song - $artist")
  echo $full_name
  spotdl download "$full_name"
}

function aytdll(){
  python ~/Developments/JavaScript/test/a.py
  ytdl -a tmp_list.txt
  ls *.mp4 | sort -t '.' -k2 -n > playlist.txt
  mpv --playlist=playlist.txt
  rm tmp_list.txt
}
function qrcode(){
  curl -d "$1" qrcode.show
}

#macfeh cli integration
function macfeh() {
    open -b "drabweb.macfeh" "$@"
}

# Global Variables used in audio editing 
export filter64="equalizer=f=64:width_type=o:w=3.3:g="
export filter400="equalizer=f=400:width_type=o:w=2.0:g="
export filter1250="equalizer=f=1250:width_type=o:w=1.3:g="
export filter2830="equalizer=f=2830:width_type=o:w=1.0:g="
export filter5600="equalizer=f=5600:width_type=o:w=1.0:g="


export HISTCONTROL=ignoreboth


alias config='/usr/bin/git --git-dir=~/.cfg/ --work-tree=/~'

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


export PATH="$PATH:$HOME/.rvm/bin"

# python-click>=8.0
eval "$(_PYMOBILEDEVICE3_COMPLETE=zsh_source pymobiledevice3)"

# Set typewritten ZSH as a prompt
autoload -U promptinit; promptinit
prompt typewritten; 

### PROMPT CUSTOMIZATION
TYPEWRITTEN_CURSOR="block"
TYPEWRITTEN_LEFT_PROMPT_PREFIX_FUNCTION=($date +%H:%M:%S)
TYPEWRITTEN_ARROW_SYMBOL="➜"

export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
eval "$(zoxide init zsh)"

# bun completions
[ -s "/Users/eashanc/.bun/_bun" ] && source "/Users/eashanc/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

#mojo
export MODULAR_HOME="$HOME/.modular"
export PATH="$MODULAR_HOME/pkg/packages.modular.com_mojo/bin:$PATH"
