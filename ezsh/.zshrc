# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

################# DO NOT MODIFY THIS FILE #######################
####### PLACE YOUR CONFIGS IN ~/.config/ezsh/zshrc FOLDER #######
#################################################################

# This file is created by ezsh setup.
# Place all your .zshrc configurations / overrides in a single or multiple files under ~/.config/ezsh/zshrc/ folder
# Your original .zshrc is backed up at ~/.zshrc-backup-%y-%m-%d


# Load ezsh configurations
source "$HOME/.config/ezsh/ezshrc.zsh"

# Any zshrc configurations under the folder ~/.config/ezsh/zshrc/ will override the default ezsh configs.
# Place all of your personal configurations over there
ZSH_CONFIGS_DIR="$HOME/.config/ezsh/zshrc"

if [ "$(ls -A $ZSH_CONFIGS_DIR)" ]; then
    for file in "$ZSH_CONFIGS_DIR"/*; do
        source "$file"
    done
fi

# Now source oh-my-zsh.sh so that any plugins added in ~/.config/ezsh/zshrc/* files also get loaded
source $ZSH/oh-my-zsh.sh


# Configs that can only work after "source $ZSH/oh-my-zsh.sh", such as Aliases that depend oh-my-zsh plugins

# Now source fzf.zsh , otherwise Ctr+r is overwritten by ohmyzsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPS="--extended"

alias k="k -h"       # show human readable file sizes, in kb, mb etc

alias g="git"

unsetopt BEEP

bindkey '^I'  fzf-tab-complete     # tab          | complete
bindkey '^ ' autosuggest-accept    # ctrl + space | autosuggest

# bindkey "ç" fzf-cd-widget # fzf alt-c for macos

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export PATH="/usr/local/opt/sqlite/bin:$PATH"

export VISUAL=nvim
export EDITOR=$VISUAL

eval "$(zoxide init zsh)"
