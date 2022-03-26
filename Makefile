.ONESHELL:
SHELL := $(shell which bash)

# https://superuser.com/a/1107191/1146694
# chassis types with touchscreen (rough estimate)
CT_TOUCHSCR := 30 31 32
# chassis types with touchpad (rough estimate)
CT_TOUCHPAD := 9 31 32

DEST := $(HOME)/.local/bin

FEATURES := default

ifneq ($(shell command -v nix),)
  FEATURES := $(FEATURES) nix
endif
ifneq ($(shell command -v pacman),)
  FEATURES := $(FEATURES) arch
endif
ifneq ($(shell command -v wine),)
  FEATURES := $(FEATURES) wine
endif
ifneq ($(shell command -v pandocomatic),)
  FEATURES := $(FEATURES) pandocomatic
endif
ifneq ($(shell command -v instantwm),)
  FEATURES := $(FEATURES) instantwm
endif
ifneq ($(filter $(CT_TOUCHSCR),$(shell cat /sys/class/dmi/id/chassis_type)),)
  FEATURES := $(FEATURES) touchscreen
endif
ifneq ($(filter $(CT_TOUCHPAD),$(shell cat /sys/class/dmi/id/chassis_type)),)
  FEATURES := $(FEATURES) touchpad
endif

$(info FEATURES: $(FEATURES))

.PHONY: install-all
install-all: $(DEST)/ $(foreach F,$(FEATURES),$(wildcard $(CURDIR)/$(F)/*))
	@echo "linking $(filter-out $<,$^) to $<"
	ln -sf $(filter-out $<,$^) "$<"

# catch-all mkdir
%/:
	mkdir -p "$@"
