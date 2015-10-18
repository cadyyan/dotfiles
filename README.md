# Setup

Setup is pretty easy but you are required to have a few components installed.

## Dependencies

 * CMake
 * Python
 * Vim (7.0+)
 * Patched Fonts (provided by `tools/nerd-fonts`)
 * Tidy (found in the `tools` directory)
 * Exuberant CTags
 * Zsh
 * Pip
 * python-dev
 * htop
 * tmux
 * tmuxp

## Optional

 * Install Solarized Dark theme for the terminal (also found in the `tools` directory)
 * joe

## Basic Installation

1. git clone https://github.com/cadyyan/dotfiles.git
2. cd dotfiles
3. git submodule update --init --recursive --depth 1
4. cd tools/nerd-fonts
5. ./install.sh
6. cd ../gnome-terminal-colors-solarized
7. ./install.sh

You can then proceed to make symlinks to any config files you might want.

### Vim

To setup Vim you must fist symlink the Vim config provided to your home directory.

	ln -s /path/to/dotfiles/vimrc ~/.vimrc

Then you must link the provided vim components.

	ln -s /path/to/dotfiles/vim ~/.vim

Install all the Vim plugins by running the following command:

	vim +PluginInstall +qall

There's some extra work that you'll need to do to setup the YouCompleteMe plugin.

	mkdir ~/ycmd
	cd ~/ycmd
	wget http://llvm.org/releases/3.7.0/clang+llvm-3.7.0-x86_64-linux-gnu-ubuntu-14.04.tar.xz
	tar xf clang+llvm-3.7.0-x86_64-linux-gnu-ubuntu-14.04.tar.xz
	mv clang+llvm-3.7.0-x86_64-linux-gnu-ubuntu-14.04 llvm_root_dir
	rm clang+llvm-3.7.0-x86_64-linux-gnu-ubuntu-14.04.tar.xz
	cmake -G "Unix Makefiles" -DPATH_TO_LLVM_ROOT=~/ycmd/llvm_root_dir . ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp
	make ycm_support_libs

