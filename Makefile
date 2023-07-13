simpleBootloader: simpleBootloader.asm

	nasm -f bin ./simpleBootloader.asm -o ./simpleBootloader.bin


run: simpleBootloader.bin
	qemu-system-x86_64 ./simpleBootloader.bin

clean:
	rm -f simpleBootloader.bin
