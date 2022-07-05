# Assembly options
AS := nasm
AS_FLAGS := -fbin 

# Kernel flags
K_FLAGS  := -Isrc/kernel/
# Bootloader flags
B_FLAGS  := -Isrc/boot/

OBJS := bin/bootsector.bin bin/kernel.bin
OBJ_DIR := bin

B_FILE := src/boot/abos-boot.asm
K_FILE := src/kernel/kernel.asm

all: create_dir boot kernel link
.PHONY: all

create_dir:
	mkdir -p $(OBJ_DIR)

boot: $(B_FILE)
	$(AS) $(AS_FLAGS) $(B_FLAGS) $^ -o $(OBJ_DIR)/bootsector.bin


kernel: $(K_FILE)
	$(AS) $(AS_FLAGS) $(K_FLAGS) $^ -o $(OBJ_DIR)/kernel.bin

link:
	cat $(OBJS) > $(OBJ_DIR)/abos.img