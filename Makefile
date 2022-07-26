CC := gcc
CFLAGS := -std=gnu99 -O2 -g

# Kernel flags
K_FLAGS  := -Isrc/kernel/ -Iinclude/
B_FLAGS  := -Isrc/boot/

OBJS := bin/bootsector.bin bin/kernel.bin
OBJ_DIR := bin

B_FILE := src/boot/abos-boot.asm
K_FILE := src/kernel/kernel.asm

all: create_dir os fat_tool
.PHONY: all

create_dir:
	@mkdir -p $(OBJ_DIR)

os:
	nasm -fbin $(B_FLAGS) src/boot/abos-boot.asm -o bin/bootsector.bin
	nasm -fbin $(K_FLAGS) src/kernel/kernel.asm -o bin/kernel.bin


	dd if=/dev/zero of=$(OBJ_DIR)/abos.img bs=512 count=2880
	mkfs.fat -F 12 -n "ABOS" $(OBJ_DIR)/abos.img
	dd if=$(OBJ_DIR)/bootsector.bin of=$(OBJ_DIR)/abos.img conv=notrunc

	mcopy -i $(OBJ_DIR)/abos.img $(OBJ_DIR)/kernel.bin "::kernel.bin"
	cat test.txt || echo "Hello, World" > test.txt
	mcopy -i $(OBJ_DIR)/abos.img test.txt "::test.txt"


fat_tool: src/tools/fat.c
	$(CC) $^ $(CFLAGS) -o ./bin/fat_tool

clean:
	@rm -rf $(OBJ_DIR) test.txt


# Debugging / Emulator
EMU := qemu-system-x86_64
DEBUG_FLAGS := -monitor stdio -d int -M smm=off -no-shutdown -no-reboot -m 512
GEN_Q_FLAGS := -debugcon stdio

qemu: bin/abos.img
	@$(EMU) $(GEN_Q_FLAGS) -fda $^

qemu-debug: bin/abos.img
	@$(EMU) $(DEBUG_FLAGS) -fda $^
