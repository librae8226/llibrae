# Useful tools
CC      := $(CROSS)gcc
CXX     := $(CROSS)g++
LD      := $(CROSS)ld -v
AR      := $(CROSS)ar
AS      := $(CROSS)gcc
OBJCOPY := $(CROSS)objcopy
DISAS   := $(CROSS)objdump
OBJDUMP := $(CROSS)objdump
SIZE    := $(CROSS)size

# Suppress annoying output unless V is set
ifndef V
    SILENT_CC       = @echo '  [CC]       ' $(@:$(BUILD_PATH)/%.o=%.c);
    SILENT_AS       = @echo '  [AS]       ' $(@:$(BUILD_PATH)/%.o=%.S);
    SILENT_CXX      = @echo '  [CXX]      ' $(@:$(BUILD_PATH)/%.o=%.cpp);
    SILENT_LD       = @echo '  [LD]       ' $(@F);
    SILENT_AR       = @echo '  [AR]       ' $(@F);
    SILENT_OBJCOPY  = @echo '  [OBJCOPY]  ' $(@F);
    SILENT_DISAS    = @echo '  [DISAS]    ' $(@:$(BUILD_PATH)/%.bin=%).disas;
    SILENT_OBJDUMP  = @echo '  [OBJDUMP]  ' $(OBJDUMP);
endif

BUILDDIRS     :=
TGT_BIN       :=
USR_BUILDDIRS :=
USR_TGT_BIN   :=

CFLAGS   = $(GLOBAL_CFLAGS) $(TGT_CFLAGS)
CXXFLAGS = $(GLOBAL_CXXFLAGS) $(TGT_CXXFLAGS)
ASFLAGS  = $(GLOBAL_ASFLAGS) $(TGT_ASFLAGS)

# General directory independent build rules, generate dependency information
$(BUILD_PATH)/%.o: %.c
	$(SILENT_CC) $(CC) $(CFLAGS) -MMD -MP -MF $(@:%.o=%.d) -MT $@ -o $@ -c $<

$(BUILD_PATH)/%.o: %.cpp
	$(SILENT_CXX) $(CXX) $(CFLAGS) $(CXXFLAGS) -MMD -MP -MF $(@:%.o=%.d) -MT $@ -o $@ -c $<

$(BUILD_PATH)/%.o: %.S
	$(SILENT_AS) $(AS) $(ASFLAGS) -MMD -MP -MF $(@:%.o=%.d) -MT $@ -o $@ -c $<

