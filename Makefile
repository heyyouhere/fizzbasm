fizzbasm:
	nasm -f elf -g -o "fizzbasm.o" "fizzbasm.asm"
	ld -m elf_i386 "fizzbasm.o" -o "fizzbasm"
	rm "fizzbasm.o"
