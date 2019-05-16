all: helloworldprintf

helloworldprintf.o: helloworldprintf.asm
	nasm -f elf32 -g helloworldprintf.asm

helloworldprintf: helloworldprintf.o
	gcc -m32 -o helloworldprintf helloworldprintf.o

clean:
	rm -rf *.txt *.o helloworldprintf