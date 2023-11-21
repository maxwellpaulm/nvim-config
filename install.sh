# constants
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
USER_CONFIG_DIR=$HOME/.config

# functions
link_config () {
    echo ""
    PROG_CONFIG_DIR=$USER_CONFIG_DIR/$1
    ln -v -s -f $SCRIPT_DIR $PROG_CONFIG_DIR
    echo "Linked $1 config"
}

link_config "nvim"
