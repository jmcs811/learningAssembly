all = numbercomp

numbercomp: numbercomp.o
	gcc -m32 -o numbercomp numbercomp.o

numbercomp.o: numbercomp.asm
	nasm -f elf32 -g numbercomp.asm

clean:
	rm -rf *.o numbercomp