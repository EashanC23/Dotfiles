###################################################
##########            Options            ##########
###################################################

export ZSH="$HOME/.oh-my-zsh"
export EDITOR="nvim"
export VISUAL="nvim"

setopt hist_ignore_dups
setopt hist_ignore_space
fpath+=(~/.zfunctions)

eval "$(zoxide init zsh)" # initalizing zoxide on start

###################################################
##########           oh-my-zsh           ##########
###################################################
ZSH_THEME=""
ZSH_DISABLE_COMPFIX=true
DISABLE_AUTO_TITLE="true"

plugins=(brew fzf git iterm2 macos rust thefuck zsh-syntax-highlighting zsh-autosuggestions zsh-interactive-cd zoxide) 

zstyle :omz:plugins:iterm2 shell-integration yes
zstyle ':omz:update' mode reminder  # just remind me to update when it's time to update
source $ZSH/oh-my-zsh.sh



###################################################
##########            Prompt            ###########
###################################################

autoload -U promptinit; promptinit
prompt typewritten; 

# Prompt Customization
TYPEWRITTEN_CURSOR="block"
TYPEWRITTEN_LEFT_PROMPT_PREFIX_FUNCTION=($date +%H:%M:%S)
TYPEWRITTEN_ARROW_SYMBOL="➜"



###################################################
##########            Aliases            ##########
###################################################
source .aliases.zsh


###################################################
##########           Bindings            ##########
###################################################
source .bindings.zsh


###################################################
##########             fzf              ###########
###################################################
source .fzf.zsh

###################################################
##########            Exports            ##########
###################################################

# Path stuff and acompanying subsidiary commands
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
