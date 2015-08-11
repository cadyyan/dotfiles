# Setup

Setup is pretty easy but you are required to have a few components installed.

## Dependencies

 * CMake
 * Clang
 * libclang
 * Vim
 * Patched Fonts (provided by `tools/nerd-fonts`)
 * Tidy (found in the `tools` directory)
 * Exuberant CTags
 * Zsh
 * Pip

## Optional

 * Install Solarized Dark theme for the terminal (also found in the `tools` directory)

### Vim

To setup Vim you must fist symlink the Vim config provided to your home directory.

	ln -s /path/to/dotfiles/vimrc ~/.vimrc

Then you must link the preprovided vim components.

	ln -s /path/to/dotfiles/vim ~/.vim

