
# Standard things
sp              := $(sp).x
dirstack_$(sp)  := $(d)
d               := $(dir)
BUILDDIRS       += $(BUILD_PATH)/$(d)/algorithm
BUILDDIRS       += $(BUILD_PATH)/$(d)/ds
BUILDDIRS       += $(BUILD_PATH)/$(d)/math

LIB_INCLUDES := -I$(LIB_PATH)

# Local flags
#CFLAGS_$(d) = -I$(d) -Wall -Werror
CFLAGS_$(d) = -I$(d) -Wall

# Local rules and targets
cSRCS_$(d) += math/fast_inverse_sqrt.c

cFILES_$(d) := $(cSRCS_$(d):%=$(d)/%)
sFILES_$(d) := $(sSRCS_$(d):%=$(d)/%)

OBJS_$(d) := $(cFILES_$(d):%.c=$(BUILD_PATH)/%.o) $(sFILES_$(d):%.S=$(BUILD_PATH)/%.o)
DEPS_$(d) := $(OBJS_$(d):%.o=%.d)

$(OBJS_$(d)): TGT_CFLAGS := $(CFLAGS_$(d))
$(OBJS_$(d)): TGT_ASFLAGS :=

TGT_BIN += $(OBJS_$(d))

# Standard things
-include $(DEPS_$(d))
d := $(dirstack_$(sp))
sp := $(basename $(sp))

