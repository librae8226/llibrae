$(BUILD_PATH)/$(LIBRARY_TARGET): $(BUILDDIRS) $(TGT_BIN) $(USR_BUILDDIRS) $(USR_TGT_BIN)
	$(SILENT_LD) $(CC) $(LDFLAGS) -o $@ $(TGT_BIN) $(USR_TGT_BIN) -Wl,-Map,$(BUILD_PATH)/$(LIBRARY_TARGET).map
	$(SILENT_DISAS) $(DISAS) -d $(BUILD_PATH)/$(LIBRARY_TARGET) > $(BUILD_PATH)/$(LIBRARY_TARGET).disas
	@echo " "
	@echo "Object file sizes:"
	@find $(BUILD_PATH) -iname *.o | xargs $(SIZE) -t > $(BUILD_PATH)/$(LIBRARY_TARGET).sizes
	@cat $(BUILD_PATH)/$(LIBRARY_TARGET).sizes
	@echo " "
	@echo "Final Size:"
	@$(SIZE) $(BUILD_PATH)/$(LIBRARY_TARGET)
	@echo $(TARGET_PLATFORM) > $(BUILD_PATH)/build-type

