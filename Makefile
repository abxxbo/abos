AS := nasm

all: abos abos-run
.PHONY: all

abos:
	mkdir -p bin/
	$(AS) -f bin src/abos-boot.asm -o bin/bootsector.bin

abos-run: bin/bootsector.bin
	qemu-system-x86_64 -drive format=raw,file=bin/bootsector.bin

clean:
	rm -rf bin