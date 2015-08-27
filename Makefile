TARGETS = $(filter-out Makefile scripts, $(shell ls))

all: $(foreach f, $(TARGETS), install-$(f)) install-load.sh

install-load.sh: scripts/load.sh
	mkdir -p $(HOME)/.local/bin/
	chmod +x $(CURDIR)/$<
	ln -snf $(CURDIR)/$< $(HOME)/.local/bin/load.sh

install-%: %
	ln -snf $(CURDIR)/$< $(HOME)/.$<

clean:
	cd $(EMACSD); make clean
