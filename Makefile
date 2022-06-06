AS := nasm

all: abos abos-run
.PHONY: all

abos:
	mkdir -p bin/
	$(AS) -f bin -Isrc/ src/abos-boot.asm -o bin/bootsector.bin
	$(AS) -Isrc/ src/kernel/kernel.asm -o bin/kernel.bin

	cat bin/bootsector.bin bin/kernel.bin > bin/abos.img

abos-run: bin/abos.img
	qemu-system-x86_64 -drive format=raw,file=$^

clean:
	rm -rf bin