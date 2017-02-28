
DOTFILES = $(filter-out Makefile scripts vscode, $(shell ls))
SCRIPTS = $(shell ls scripts/*)

.PHONY: all
all: dotfiles scripts vscode

.PHONY: dotfiles
dotfiles: $(foreach f, $(DOTFILES), install-dotfile-$(f))

.PHONY: vscode
vscode:
	cd ./vscode; make

install-dotfile-%: %
	ln -snf $(CURDIR)/$< $(HOME)/.$<

install-script-%: scripts/%
	mkdir -p $(HOME)/bin
	ln -snf $(CURDIR)/$< $(HOME)/bin/$(notdir $<)
