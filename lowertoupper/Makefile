all = lowertoupper

lowertoupper: lowertoupper.o
	gcc -m32 -o lowertoupper lowertoupper.o

lowertoupper.o: lowertoupper.asm
	nasm -f elf32 -g lowertoupper.asm

clean:
	rm -rf *.o lowertoupper