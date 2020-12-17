
DOTFILES = $(filter-out Makefile scripts fonts.conf, $(shell ls))

.PHONY: all
all: dotfiles install-fonts.conf

.PHONY: dotfiles
dotfiles: $(foreach f, $(DOTFILES), install-dotfile-$(f))

install-fonts.conf:
	mkdir -p $(HOME)/.config/fontconfig
	ln -snf $(CURDIR)/fonts.conf $(HOME)/.config/fontconfig/fonts.conf

install-dotfile-%: %
	ln -snf $(CURDIR)/$< $(HOME)/.$<

install-script-%: scripts/%
	mkdir -p $(HOME)/bin
	ln -snf $(CURDIR)/$< $(HOME)/bin/$(notdir $<)
