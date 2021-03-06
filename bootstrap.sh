#!/bin/bash

# We want to ensure these directories exist
DIRS=(
    "$HOME/bin"
    "$HOME/.xmonad"
)

# Config files within the repository
FILE_PATHS=(
    "$HOME/.dotfiles/bash/bashrc"
    "$HOME/.dotfiles/bash/bash"
    "$HOME/.dotfiles/git/gitconfig"
    "$HOME/.dotfiles/git/gitignore_global"
    "$HOME/.dotfiles/hg/hgrc"
    "$HOME/.dotfiles/hg/hgignore"
    "$HOME/.dotfiles/irb/irbrc"
    "$HOME/.dotfiles/irssi"
    "$HOME/.dotfiles/screen/screenrc"
    "$HOME/.dotfiles/scripts/spotify-cli-wrapper"
    "$HOME/.dotfiles/tmux/tmux.conf"
    "$HOME/.dotfiles/tmux/tmux-start"
    "$HOME/.dotfiles/vim/vimrc"
    "$HOME/.dotfiles/vim/vim"
    "$HOME/.dotfiles/xmonad/xmonad.hs"
)

# Paths at which we want to create symlinks to the config files
LINK_PATHS=(
    "$HOME/.bashrc"
    "$HOME/.bash"
    "$HOME/.gitconfig"
    "$HOME/.gitignore_global"
    "$HOME/.hgrc"
    "$HOME/.hgignore"
    "$HOME/.irbrc"
    "$HOME/.irssi"
    "$HOME/.screenrc"
    "$HOME/bin/spotify-cli-wrapper"
    "$HOME/.tmux.conf"
    "$HOME/bin/tmux-start"
    "$HOME/.vimrc"
    "$HOME/.vim"
    "$HOME/.xmonad/xmonad.hs"
)

function create_dir() {
    DIR_PATH=$1

    # Create directory if it doesn't exist,
    # or fail if it exists and is not a directory.
    if [ -e "$DIR_PATH" ]; then
        if [ ! -d "$DIR_PATH" ]; then
            echo "${DIR_PATH} exists and is not a directory!"
            exit 1
        fi
    else
        mkdir -pv $DIR_PATH
    fi
}

function create_link() {
    FILE_PATH=$1
    LINK_PATH=$2

    # Remove other files (-h => only if they're symlinks already => a bit safer)
    [ -h $LINK_PATH ] && rm -v $LINK_PATH
    # Create a symlink to the file
    ln -sv $FILE_PATH $LINK_PATH
}

if [ "$PWD" != "$HOME/.dotfiles" ]; then
    echo "Please execute bootstrap.sh from .dotfiles directory in $HOME"
    exit 1
else
    # Create any directories which don't exist.
    for DIR in ${DIRS[@]}; do
        echo $DIR
        create_dir $DIR
    done

    # Create the symlinks - assumes both arrays are the same length!
    for ((i = 0; i < ${#FILE_PATHS[@]}; i++)); do
        create_link ${FILE_PATHS[$i]} ${LINK_PATHS[$i]}
    done

    # Let's sort out all the vim submodules
    git submodule init
    git submodule update

    # source ~/.bash_profile
    cd $HOME
    echo "Initialisation complete!"
fi
