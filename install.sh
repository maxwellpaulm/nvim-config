SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
USER_CONFIG_DIR=$HOME/.config
rm -r $PROG_CONFIG_DIR
ln -v -s $SCRIPT_DIR $USER_CONFIG_DIR/nvim

