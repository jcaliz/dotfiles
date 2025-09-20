export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git)

source $ZSH/oh-my-zsh.sh

#custom aliases
alias ll='ls -lh --group-directories-first'

# CUDA
export PATH=/usr/local/cuda-12.8/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda-12.8/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
export TELEGRAM_TOKEN='6196947006:AAFweeHhrpKpjSNCON2RcDCURuBunftEF_o'

# history configs
export HISTSIZE=5000000
export SAVEHIST=$HISTSIZE

# HISTORY
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt SHARE_HISTORY             # Share history between all sessions.
# END HISTORY

## Include _ as part of words
export WORDCHARS='*?_[]~=&;!#$%^(){}'

## Shell only exists after the 10th consecutive Ctrl-d
setopt ignore_eof

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!

__conda_setup="$('/home/josecaliz/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/josecaliz/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/josecaliz/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/josecaliz/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup

function conda_activate() {
    ENV_NAME="$1"
    USER=`whoami`
    conda activate $ENV_NAME || return 1
    alias pip='/home/${USER}/miniconda3/envs/${ENV_NAME}/bin/pip'
    alias pip3='/home/${USER}/miniconda3/envs/${ENV_NAME}/bin/pip3'
    alias ipython='/home/${USER}/miniconda3/envs/${ENV_NAME}/bin/ipython'
    alias python='/home/${USER}/miniconda3/envs/${ENV_NAME}/bin/python'
}

function conda_deactivate() {
    conda deactivate;
    conda deactivate;
    unalias pip
    unalias ipython
    unalias python
}

alias ca="conda_activate"
alias cde="conda_deactivate"

## more keys for easier editing
bindkey "^e" beginning-of-line
bindkey "^a" end-of-line
bindkey "^h" backward-word
bindkey "^l" forward-word
bindkey "^f" history-incremental-search-forward
bindkey "^r" history-incremental-search-backward
bindkey "^g" send-break
bindkey "^n" down-history
bindkey "^p" up-history
bindkey "^u" undo
bindkey "^w" backward-kill-word
bindkey "^d" kill-word
bindkey "^s" delete-char
bindkey "^t" backward-delete-char
stty intr ^G

# Created by `pipx` on 2025-05-20 16:54:10
export PATH="$PATH:/home/josecaliz/.local/bin"

# Custom Prompt to add a happy face
PROMPT="%{$fg_bold[green]%}\(•◡•)/%{$reset_color%} %(?:%{$fg_bold[green]%}%1{➜%} :%{$fg_bold[red]%}%1{➜%}) %{$fg[cyan]%}%c%{$reset_color%}"
PROMPT+=' $(git_prompt_info)'