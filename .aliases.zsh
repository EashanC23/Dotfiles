#################################################
########          User Aliases          #########
#################################################
eval $(thefuck --alias)
alias tree="tree -h --sort size --du"
alias bsr="brew services restart" 
alias ytdlmp3="yt-dlp --audio-format mp3 -x --external-downloader aria2c --external-downloader-args '-c -j 5 -x 10 --summary-interval=0'  -o \"%(title)s.%(ext)s\""
alias ytdl="yt-dlp --external-downloader aria2c --external-downloader-args '-c -j 5 -x 10 --summary-interval=0' -o \"%(title)s.%(ext)s\""
alias ls='lsd'
alias lt='lsd --tree'
alias reload="source $HOME/.zshrc"
alias cat='bat'
alias oo='open .'
alias python='python3.11'
alias cr='cargo run'
alias rmld='rm -rf $(1)'
alias lg='lazygit'
alias config='/usr/bin/git --git-dir=~/.cfg/ --work-tree=/~'
alias rm='trash'
alias dot='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
source ~/.env


# Global Variables used in audio editing 
export filter64="equalizer=f=64:width_type=o:w=3.3:g="
export filter400="equalizer=f=400:width_type=o:w=2.0:g="
export filter1250="equalizer=f=1250:width_type=o:w=1.3:g="
export filter2830="equalizer=f=2830:width_type=o:w=1.0:g="
export filter5600="equalizer=f=5600:width_type=o:w=1.0:g="



#################################################
########        User functions          #########
#################################################
## Development
# Java 
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
    javac $1 && java $r "$@"
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

