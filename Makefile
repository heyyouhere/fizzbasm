all: fizzbasm print_number

fizzbasm:
	nasm -f elf -g -o "fizzbasm.o" "fizzbasm.asm"
	ld -m elf_i386 "fizzbasm.o" -o "fizzbasm"
	rm "fizzbasm.o"

print_number:
	nasm -f elf -g -o "print_number.o" "print_number.asm"
	ld -g -m elf_i386 "print_number.o" -o "print_number"
	rm "print_number.o"
