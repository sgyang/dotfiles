
SETTINGS_DIR=$(HOME)/.config/Code/User

.PHONY: all
all: $(SETTINGS_DIR)/settings.json $(SETTINGS_DIR)/keybindings.json

$(SETTINGS_DIR)/settings.json: settings.json
	mkdir -p $(SETTINGS_DIR)
	ln -snf $(CURDIR)/$< $@

$(SETTINGS_DIR)/keybindings.json: keybindings.json
	mkdir -p $(SETTINGS_DIR)
	ln -snf $(CURDIR)/$< $@
