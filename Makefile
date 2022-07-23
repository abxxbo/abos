# Assembly options
AS := nasm
AS_FLAGS := -fbin 

# Kernel flags
K_FLAGS  := -Isrc/kernel/ -Iinclude/
# Bootloader flags
B_FLAGS  := -Isrc/boot/

OBJS := bin/bootsector.bin bin/kernel.bin
OBJ_DIR := bin

B_FILE := src/boot/abos-boot.asm
K_FILE := src/kernel/kernel.asm

all: create_dir os
.PHONY: all

create_dir:
	@mkdir -p $(OBJ_DIR)

sh := $(SHELL) -e
t:
	@echo $(sh)

os:
	@$(AS) $(AS_FLAGS) $(B_FLAGS) $(B_FILE) -o $(OBJ_DIR)/bootsector.bin
	@if [ "`$(AS) $(AS_FLAGS) $(K_FLAGS) $(K_FILE) -o $(OBJ_DIR)/kernel.bin`" != "" ]; then \
		echo No warnings/errors generated.; \
	else \
		printf "\033[0;31m==> Warnings/errors generated.$(shell tput init)\n"; \
	fi
	@cat $(OBJS) > $(OBJ_DIR)/abos.img

clean:
	@rm -rf $(OBJ_DIR)


# Debugging / Emulator
EMU := qemu-system-x86_64
DEBUG_FLAGS := -monitor stdio -d int -M smm=off -no-shutdown -no-reboot -m 512
GEN_Q_FLAGS := -debugcon stdio

qemu: bin/abos.img
	@$(EMU) $(GEN_Q_FLAGS) -fda $^

qemu-debug: bin/abos.img
	@$(EMU) $(DEBUG_FLAGS) -fda $^
