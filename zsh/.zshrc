export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git)

source $ZSH/oh-my-zsh.sh

#custom aliases
if [[ "$OSTYPE" == linux-gnu ]]; then  # Is this the Ubuntu system?
    alias ll='ls -Flh --group-directories-first'
elif [[ "$OSTYPE" == darwin* ]]; then  # macOS
    # Check if GNU coreutils is installed (brew install coreutils)
    if command -v gls > /dev/null 2>&1; then
        alias ll='gls -Flh --group-directories-first --color'
    else
        alias ll='ls -Flh'
    fi
else
    alias ll='ls -Flh'
fi

# CUDA
export PATH=/usr/local/cuda-12.8/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda-12.8/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}

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

# Detect conda installation path based on OS
if [[ "$OSTYPE" == darwin* ]]; then
    # macOS paths
    CONDA_BASE="$HOME/miniconda3"
    if [ ! -d "$CONDA_BASE" ]; then
        CONDA_BASE="$HOME/anaconda3"
    fi
else
    # Linux paths
    CONDA_BASE="$HOME/miniconda3"
fi

if [ -d "$CONDA_BASE" ]; then
    __conda_setup="$('$CONDA_BASE/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "$CONDA_BASE/etc/profile.d/conda.sh" ]; then
            . "$CONDA_BASE/etc/profile.d/conda.sh"
        else
            export PATH="$CONDA_BASE/bin:$PATH"
        fi
    fi
fi
unset __conda_setup

function conda_activate() {
    ENV_NAME="$1"
    USER=`whoami`
    conda activate $ENV_NAME || return 1
    
    # Detect conda base path based on OS
    if [[ "$OSTYPE" == darwin* ]]; then
        # macOS paths
        if [ -d "$HOME/miniconda3" ]; then
            CONDA_BASE="$HOME/miniconda3"
        elif [ -d "$HOME/anaconda3" ]; then
            CONDA_BASE="$HOME/anaconda3"
        else
            echo "Warning: Could not find conda installation"
            return 1
        fi
    else
        # Linux paths
        CONDA_BASE="$HOME/miniconda3"
    fi
    
    alias pip="${CONDA_BASE}/envs/${ENV_NAME}/bin/pip"
    alias pip3="${CONDA_BASE}/envs/${ENV_NAME}/bin/pip3"
    alias ipython="${CONDA_BASE}/envs/${ENV_NAME}/bin/ipython"
    alias python="${CONDA_BASE}/envs/${ENV_NAME}/bin/python"
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
# Add pipx local bin to PATH based on OS
if [[ "$OSTYPE" == darwin* ]]; then
    # macOS path
    if [ -d "$HOME/.local/bin" ]; then
        export PATH="$PATH:$HOME/.local/bin"
    fi
else
    # Linux path
    if [ -d "$HOME/.local/bin" ]; then
        export PATH="$PATH:$HOME/.local/bin"
    fi
fi

# Custom Prompt to add a happy face
PROMPT="%{$fg_bold[green]%}\(•◡•)/%{$reset_color%} %(?:%{$fg_bold[green]%}%1{➜%} :%{$fg_bold[red]%}%1{➜%}) %{$fg[cyan]%}%c%{$reset_color%}"
PROMPT+=' $(git_prompt_info)'