all = numbercompare

numbercompare: numbercompare.o
	gcc -m32 -o numbercompare numbercompare.o

numbercompare.o: numbercompare.asm
	nasm -f elf32 -g numbercompare.asm

clean:
	rm -rf *.o numbercompare
