# Assembly options
AS := nasm
AS_FLAGS := -fbin 

# Kernel flags
K_FLAGS  := -Isrc/kernel/ -Ilang/
# Bootloader flags
B_FLAGS  := -Isrc/boot/

OBJS := bin/bootsector.bin bin/kernel.bin
OBJ_DIR := bin

B_FILE := src/boot/abos-boot.asm
K_FILE := src/kernel/kernel.asm

all: create_dir os
.PHONY: all

create_dir:
	mkdir -p $(OBJ_DIR)

os:
	@$(AS) $(AS_FLAGS) $(B_FLAGS) $(B_FILE) -o $(OBJ_DIR)/bootsector.bin
	@$(AS) $(AS_FLAGS) $(K_FLAGS) $(K_FILE) -o $(OBJ_DIR)/kernel.bin
	@cat $(OBJS) > $(OBJ_DIR)/abos.img

# Debugging / Emulator
EMU := qemu-system-x86_64

DEBUG_FLAGS := -monitor stdio -d int -M smm=off -no-shutdown -no-reboot -m 512
GEN_Q_FLAGS := -debugcon stdio -m 512

qemu: bin/abos.img
	$(EMU) $(GEN_Q_FLAGS) -fda $^

qemu-debug: bin/abos.img
	$(EMU) $(DEBUG_FLAGS) -fda $^