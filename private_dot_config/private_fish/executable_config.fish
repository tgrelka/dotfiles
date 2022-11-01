### Init Hooks ###

# Initialize direnv hook
direnv hook fish | source
# Initialize Starship prompt
starship init fish | source
# Initialize thefuck command corrector 
thefuck --alias | source
# Initialize zoxide "smart cd"
zoxide init fish | source


### Fish Configuration ###

set fish_greeting # Suppress fish greeter
set fish_cursor_default block # Set the normal and visual mode cursors to a block
set fish_cursor_insert line # Set the insert mode cursor to a line
set fish_cursor_replace_one underscore # Set the replace mode cursor to an underscore

### EXPORT ###

set -x TERM xterm-256color # Set terminal type
set -x EDITOR vim # $EDITOR to use vim in terminal
set -x VISUAL code # $VISUAL to use Code in GUI mode
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'" # Use bat as manpager for colourful output
set -x FX_LANG node # Use Node as JS engine for fx

### FUNCTIONS ###

# Enable keybindings
function fish_user_key_bindings
    fish_vi_key_bindings
end

# Function for creating a backup file
# ex: backup file.txt
# result: copies file as file.txt.bak
function backup --argument filename
    cp $filename $filename.bak
end

# Functions needed for !! and !$
function __history_previous_command
    switch (commandline -t)
        case "!"
            commandline -t $history[1]
            commandline -f repaint
        case "*"
            commandline -i !
    end
end

function __history_previous_command_arguments
    switch (commandline -t)
        case "!"
            commandline -t ""
            commandline -f history-token-search-backward
        case "*"
            commandline -i '$'
    end
end

# The bindings for !! and !$
if [ $fish_key_bindings = fish_vi_key_bindings ]
    bind -Minsert ! __history_previous_command
    bind -Minsert '$' __history_previous_command_arguments
else
    bind ! __history_previous_command
    bind '$' __history_previous_command_arguments
end

function gti
    echo -e "\033[3;31mWroom, wroom!"
end

### ALIASES ###

# Misc
alias cl='clear'
alias run='./run.sh'

# navigation
alias ..='cd ..'
alias ...='cd ../..'
alias .2='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# Editors
alias vim='nvim'

# bat
alias cat='bat'
alias c='cat'

# exa as replacement for ls
# Swap cyan and blue, expcept for bl (number of blocks).
alias exac='EXA_COLORS="gm=36:da=36:di=36:ln=34:lp=34" exa --icons --color=always'
alias exag='exac --group-directories-first'
alias ls='exag' # default listing
alias la='ls -a' # list all
alias ll='ls -l' # list long
alias lt='la -T -L 1'
alias lt1='lt -L 2'
alias lt2='lt -L 3'
alias lt3='lt -L 4'

# long versions
alias lsl='ls -l' # for completeness
alias lal='la -l' # for completeness
alias ltl='lt -l -L 1'
alias lt1l='lt1 -l'
alias lt2l='lt2 -l'
alias lt3l='lt3 -l'

# shorthands
alias l='ls'
alias a='la'
alias t='lt1'
alias tl='lt1l'

# confirm all file operations
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

# shorthand for recursive file operations
alias cpr='cp -r'
alias mvr='mv -r'
alias rmr='rm -r'

# TODO check what requires this
# likely for php-fpm
fish_add_path /usr/local/sbin

set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH

set -gx NODE_PATH (npm root --location=global)

# pnpm
set -gx PNPM_HOME /Users/tgrelka/Library/pnpm
set -gx PATH "$PNPM_HOME" $PATH
# pnpm end
