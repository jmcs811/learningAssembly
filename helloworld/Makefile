all: helloworld

helloworld.o: helloworld.asm
	nasm -f elf32 -g helloworld.asm

helloworld: helloworld.o
	ld -m elf_i386 -o helloworld helloworld.o

clean:
	rm -rf *.txt *.o helloworld