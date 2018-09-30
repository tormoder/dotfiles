.PHONY: all
all: base gui

.PHONY: base
base: zsh vim git gpg dircolors bin vundle

.PHONY: gui
gui: x11 awesome xdg xcolors kde wallpapers fonts zathura

# base

.PHONY: zsh
zsh: submodules
	stow zsh

.PHONY: vim
vim: submodules
	stow vim

.PHONY: git
git:
	stow git

.PHONY: gpg
gpg:
	stow gpg

.PHONY: dircolors
dircolors:
	stow dircolors

.PHONY: bin
bin:
	stow bin

# gui

.PHONY: x11
x11:
	stow x11

.PHONY: awesome
awesome: configbak
	stow awesome

.PHONY: xdg
xdg: configbak
	stow xdg

.PHONY: xcolors
xcolors:
	stow xcolors

.PHONY: kde
kde:
	stow kde
	ln -sf ~/.kde4/share/apps/konsole ~/.local/share/konsole

.PHONY: wallpapers
wallpapers:
	stow wallpapers

.PHONY: fonts
fonts: submodules
	stow fonts

.PHONY: fontconfig
fontconfig: configbak
	stow fontconfig

.PHONY: zathura
zathura: configbak
	stow zathura

# misc 

.PHONY: configbak
configbak:
	cp -r ~/.config ~/.config-bak
	rm -rf ~/.config-bak/awesome
	rm -rf ~/.config-bak/fontconfig
	rm -rf ~/.config-bak/zathura
	rm -f ~/.config-bak/user-dirs.*

.PHONY: cpconfig
cpconfig:
	cp -r ~/.config-bak/* ~/.config/

.PHONY: vundle
vundle: vim submodules
	vim +PluginInstall +qall

.PHONY: submodules 
submodules:
	git submodule init
	git submodule update

.PHONY: updatesubmod
updatesubmod:
	git submodule foreach git checkout master
	git submodule foreach git pull

.PHONY: unstowall
unstowall:
	stow -D zsh vim git gpg dircolors bin vundle x11 awesome xdg xcolors kde wallpapers fonts zathura

.PHONY: stow
stow:
	sudo pacman -S stow
