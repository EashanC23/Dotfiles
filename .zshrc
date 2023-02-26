# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"


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
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

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

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git macos zsh-syntax-highlighting zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
#
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
fpath=($fpath "~/.zfunctions")

#User Export 
# type written configs


##### User Aliases and Functions
# aliases 
alias startYabai="brew services start yabai"
alias stopYabai="brew services stop yabai"
alias songDL="sh ~/songDL.sh"
alias tree="tree -h --sort size --du"
alias bsr="brew services restart" 
# Java functions for development 
function jcr() {
    r=$(echo $1 | cut -d'.' -f 1)
    javac $1 && java $r
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
    ffmpeg -i $1 -af "$filter64 $2 $filter400 $3" $r.mp3
    rm $1
    mv $r.mp3 $1
}
# Ease of life for pandoc because I cant be bothered to type allat 
function pdc(){
# pandoc -s --pdf-engine=xelatex --metadata=title:"Acids and Bases" -V mainfont="Arial" Acids\ and\ Bases.wiki -o Acids\ and\ Bases.pdf
  f=$(echo $1|cut -d'.' -f 1)
  pandoc -s --pdf-engine=xelatex --metadata-file=$HOME/vimwiki/basicMetadata.yaml "${@:2}" $f.wiki -o $f.pdf
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

# Set typewritten ZSH as a prompt
autoload -U promptinit; promptinit
prompt typewritten

export TYPEWRITTEN_CURSOR="block"
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
