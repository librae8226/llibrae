GLOBAL_FLAGS := -D__PLATFORM__=__X86__

GLOBAL_CFLAGS := -O2 -g3 -nostdlib -ffunction-sections -fdata-sections \
                 -Wl,--gc-sections $(GLOBAL_FLAGS)

GLOBAL_ASFLAGS := $(GLOBAL_FLAGS)

# Build Environment
SHELL	:= /bin/bash
CROSS   :=

