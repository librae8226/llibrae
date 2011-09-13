# llibrae Makefile
# Contact - librae8226@gmail.com

# TODO @LIBRARY_TARGET the name of target binary file
#      @TARGET_PLATFORM specific directory name in folder $(PLATFORM_PATH)
LIBRARY_TARGET = llibrae
TARGET_PLATFORM = x86

# Useful paths
ifeq ($(LIBRARY_HOME),)
	SRCROOT := .
else
	SRCROOT := $(LIBRARY_HOME)
endif
BUILD_PATH = build
LIB_PATH := $(SRCROOT)/lib
SUPPORT_PATH := $(SRCROOT)/support
SCRIPT_PATH := $(SRCROOT)/script
APP_PATH := $(SRCROOT)/app

include $(APP_PATH)/config.mk

.DEFAULT_GOAL := sketch

# Set up build rules and some useful templates
include $(SUPPORT_PATH)/make/build-rules.mk
include $(SUPPORT_PATH)/make/build-templates.mk

# library source modules
MODULES	:= $(LIB_PATH)
# Example application code
MODULES += $(APP_PATH)

# call each module rules.mk
$(foreach m,$(MODULES),$(eval $(call MODULE_template,$(m))))

# Main target
include $(SUPPORT_PATH)/make/build-targets.mk

.PHONY: sketch lib clean help debug cscope tags ctags

# Force a rebuild if the maple target changed
PREV_BUILD_TYPE = $(shell cat $(BUILD_PATH)/build-type 2>/dev/null)
build-check:
ifneq ($(PREV_BUILD_TYPE), $(TARGET_PLATFORM))
	$(shell rm -rf $(BUILD_PATH))
endif

sketch: $(BUILD_PATH)/$(LIBRARY_TARGET)

lib: $(BUILD_PATH)/lib$(LIBRARY_TARGET).a
	@find $(BUILD_PATH) -iname *.o | xargs $(SIZE) -t > $(BUILD_PATH)/$(LIBRARY_TARGET).sizes

$(BUILD_PATH)/lib$(LIBRARY_TARGET).a: $(BUILDDIRS) $(TGT_BIN)
	$(shell rm -f $@)
	$(SILENT_AR) $(AR) cr $(BUILD_PATH)/lib$(LIBRARY_TARGET).a $(TGT_BIN)
clean:
	rm -rf build

distclean:
	rm -rf $(BUILD_PATH)
	rm -rf tarball
	rm -f tags tags.ut tags.fn cscope.out

package:
	mkdir -p tarball
	$(SHELL) ./script/package.sh

help:
	@echo ""
	@echo "====================="
	@echo " [Library Make Help] "
	@echo "====================="
	@echo ""

