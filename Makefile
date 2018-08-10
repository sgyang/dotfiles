
DOTFILES = $(filter-out Makefile scripts vscode local-fonts.conf, $(shell ls))

.PHONY: all
all: dotfiles vscode install-local-fonts.conf

.PHONY: dotfiles
dotfiles: $(foreach f, $(DOTFILES), install-dotfile-$(f))

.PHONY: vscode
vscode:
	cd ./vscode; make

install-local-fonts.conf:
	mkdir -p $(HOME)/.config/font-manager
	ln -snf $(CURDIR)/local-fonts.conf $(HOME)/.config/font-manager/local.conf

install-dotfile-%: %
	ln -snf $(CURDIR)/$< $(HOME)/.$<

install-script-%: scripts/%
	mkdir -p $(HOME)/bin
	ln -snf $(CURDIR)/$< $(HOME)/bin/$(notdir $<)
