### Path to our oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export EDITOR="nvim"

### Options
setopt hist_ignore_dups
setopt hist_ignore_space
fpath+=(~/.zfunctions)

### Prompt
autoload -U promptinit; promptinit
prompt typewritten; 

# prompt customization
TYPEWRITTEN_CURSOR="block"
TYPEWRITTEN_LEFT_PROMPT_PREFIX_FUNCTION=($date +%H:%M:%S)
TYPEWRITTEN_ARROW_SYMBOL="➜"

# Initializing zoxide
eval "$(zoxide init zsh)"

### oh-my-zsh settings.
ZSH_THEME=""
ZSH_DISABLE_COMPFIX=true
DISABLE_AUTO_TITLE="true"

plugins=(git macos zsh-syntax-highlighting zsh-autosuggestions rust fzf brew thefuck zsh-interactive-cd zoxide) 

zstyle ':omz:update' mode reminder  # just remind me to update when it's time to update
source $ZSH/oh-my-zsh.sh



### User Aliases
eval $(thefuck --alias)
alias songDL="sh ~/songDL.sh"
alias tree="tree -h --sort size --du"
alias bsr="brew services restart" 
alias ytdlmp3="yt-dlp --audio-format mp3 -x --external-downloader aria2c --external-downloader-args '-c -j 5 -x 10 --summary-interval=0'  -o \"%(title)s.%(ext)s\""
alias ytdl="yt-dlp --external-downloader aria2c --external-downloader-args '-c -j 5 -x 10 --summary-interval=0' -o \"%(title)s.%(ext)s\""
alias ls='lsd'
alias lt='lsd --tree'
alias reload="source $HOME/.zshrc"
alias cat='bat'
alias oo='open .'
alias wipe='~/wipe.sh'
alias unwipe='~/unwipe.sh'
alias python='python3.11'
alias cr='cargo run'
alias rmld='rm -rf $(1)'
alias lg='lazygit'
alias simulate='sudo python3.11 ~/Developments/python/tkinterLocation/main.py'
alias config='/usr/bin/git --git-dir=~/.cfg/ --work-tree=/~'
source ~/.env


### User functions
## Development
# Java development 
# export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_221.jdk"
export JAVA_HOME="/opt/homebrew/opt/openjdk@21/"

function toggleJavaVers(){
    jh=$(env | grep JAVA_HOME | cut -d'=' -f 2)
    if [[ "$jh" == "/Library/Java/JavaVirtualMachines/jdk1.8.0_221.jdk" ]];then
        export JAVA_HOME="/opt/homebrew/opt/openjdk@17/"
    else
        export JAVA_HOME="/Library/Java/JavaVirtualMachines/temurin-8.jdk/"
    fi
    java -version
}

function jcr() {
    r=$(echo $1 | cut -d'.' -f 1)
    javac $1 && java $r
}

function jcrd() {
    r=$(echo $1 | cut -d'.' -f 1)
    javac -cp ".:~/Developments/Java/libraries/gpdraw.jar" $1 && java -classpath ".:~/Developments/Java/libraries/gpdraw.jar" $r

}

function javatest () {
    local directory="${1:-.}"
    cwd=$(pwd)
    wd="$cwd/$directory"
    rm -f "$wd"/*.class
    javac -cp .:/Users/eashanc/Developments/java/libraries/junit-4.13.2.jar:/Users/eashanc/Developments/java/libraries/hamcrest-core-1.3.jar "$wd"/*.java
    if [[ $? -eq 0 ]]; then
        package_name=$(echo "$directory" | sed 's/\//./g')
        java -cp .:/Users/eashanc/Developments/java/libraries/junit-4.13.2.jar:/Users/eashanc/Developments/java/libraries/hamcrest-core-1.3.jar "$package_name".RunLocalTest
    else
        echo "Compilation failed with errors."
    fi
}

function jcri(){
    r=$(echo $1 | cut -d'.' -f 1)
    javac -cp ".:~/Developments/Java/libraries/gpdraw.jar:$2" $1 && java -classpath ".:~/Developments/Java/libraries/gpdraw.jar:$2" $r
}

# Rust development

function rcr(){
    f=$(echo $1 | cut -d'.' -f 1)
    rustc $1 && ./$f 
}

## Assorted Shell functions.

# Takes in an audio file and returns a bassboosted version of the file
# $1 Audio file, $2 deep pass, $3 higher pass
function bassBoost(){
    d=$(echo $1 | cut -d'.' -f 1)
    r=$(echo "$d" + "temp")
    ffmpeg -i "$1" -loglevel error -af "$filter64 $2 , $filter400 $3" "$r.mp3"
    rm "$1"
    mv "$r.mp3" "$1"
}

# Returns the length in minutes of a video file $1
function vlength(){
  ffmpeg -i $1 2>&1 | grep Duration | cut -d ' ' -f 4 | sed s/,//
}

# Pandoc compile command for notes.
function pdc(){
  f=$(echo $1|cut -d'.' -f 1)
  pandoc $1 -o $f.pdf --pdf-engine=xelatex -V geometry:"left=25mm,right=25mm,top=10mm,bottom=25mm" -V fontsize=15pt -V monofont="Courier New" --include-in-header ~/Documents/header.tex --toc
}

# Puts the content of $1 into user clipboard.
function copy(){
  cat $1 | pbcopy
}

function file-to-clipboard() {
  osascript \
      -e 'on run args' \
      -e 'set the clipboard to POSIX file (first item of args)' \
      -e end \
      "$@"
}

# Mass downloads anime seasons. ( Probably deprecated )
function aytdll(){
  python ~/Developments/JavaScript/test/a.py
  ytdl -a tmp_list.txt
  ls *.mp4 | sort -t '.' -k2 -n > playlist.txt
  mpv --playlist=playlist.txt
  rm tmp_list.txt
}

# Returns a concatenated video given a variable amount of video file inputs
function stitch_videos() {
    if [ "$#" -lt 1 ]; then
        echo "Error: No video files provided."
        return 1
    fi
    video_list="video_list.txt"
    for video in "$@"; do
        if [[ ! -f "$video" || ! "$video" =~ \.(mp4|avi|mkv|MOV|flv)$ ]]; then
            echo "Error: '$video' is not a valid video file."
            return 1
        fi
        echo "file '$video'" >> "$video_list"
    done

    echo "Video list created successfully."

    output_video="output_video.mp4"
    echo "Running FFmpeg command to stitch videos."
    ffmpeg -f concat -safe 0 -i "$video_list" -c copy "$output_video"
    if [ $? -ne 0 ]; then
        echo "Error: FFmpeg failed to concatenate videos."
        return 1
    fi
    rm "$video_list"
    echo "Videos stitched successfully into '$output_video'."
}

#macfeh cli integration
function macfeh() {
    open -b "drabweb.macfeh" "$@"
}


### Exports 
# Global Variables used in audio editing 
export filter64="equalizer=f=64:width_type=o:w=3.3:g="
export filter400="equalizer=f=400:width_type=o:w=2.0:g="
export filter1250="equalizer=f=1250:width_type=o:w=1.3:g="
export filter2830="equalizer=f=2830:width_type=o:w=1.0:g="
export filter5600="equalizer=f=5600:width_type=o:w=1.0:g="

#Path stuff and acompanying subsidiary commands
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# Node
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "/Users/eashanc/.bun/_bun" ] && source "/Users/eashanc/.bun/_bun"

# Ruby
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"

# Python
eval "$(_PYMOBILEDEVICE3_COMPLETE=zsh_source pymobiledevice3)"


# Mojo
export MODULAR_HOME="$HOME/.modular"
export PATH="$MODULAR_HOME/pkg/packages.modular.com_mojo/bin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@18/bin:$PATH"

# Added by Windsurf
export PATH="/Users/eashanc/.codeium/windsurf/bin:$PATH"
