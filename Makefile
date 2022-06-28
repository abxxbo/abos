AS := nasm


# specific file flags
B_FLAG := -f bin -Isrc/boot/ # bootloader
K_FLAG := -Isrc/kernel/			 # kernel

# binaries and output
BINS := bin/bootsector.bin bin/kernel.bin
OUT  := bin/abos.img

B_DIR := bin/

all: abos abos-run
.PHONY: all

abos:
	mkdir -p bin/
	$(AS) $(B_FLAG) src/boot/abos-boot.asm -o bin/bootsector.bin
	$(AS) $(K_FLAG) src/kernel/kernel.asm -o bin/kernel.bin

	cat $(BINS) > $(OUT)

abos-run: $(OUT)
	qemu-system-x86_64 $(QEMU_F) -drive format=raw,file=$^

clean:
	rm -rf $(B_DIR)