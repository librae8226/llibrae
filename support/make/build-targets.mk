# main project target

include $(APP_PATH)/target.mk

$(BUILDDIRS):
	@mkdir -p $@

$(USR_BUILDDIRS):
	@mkdir -p $@
