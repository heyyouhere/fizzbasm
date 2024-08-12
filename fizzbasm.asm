%include "syscall.inc"


section .data
    number db 0

section .bss
    input_buff resb 16

section .text
    global _start
    input_buff_size db 16
    output_test db "hello, world!", 10, 0
    fizz db "Fizz", 10, 0
    basm db "Basm", 10, 0

_start:
    mov dword [number], 0 ; save number
    read 0, input_buff, input_buff_size
    jmp parse_number

parse_number:
    mov ecx, 0
    dec eax

parse_digit:
    mov bl, [input_buff + ecx] ; get the byte of the char
    sub bl, "0" ; get the int from the char
    push eax
    mov eax, [number] ; load current value of number
    imul eax, 10 ; multiply it by 10
    add eax, ebx ; add current digit
    mov [number], eax ; save number
    pop eax
    inc ecx ; dec counter
    cmp ecx, eax; check if some left
    jne parse_digit
    mov cx, [number]

print_number_times:
    dec ecx
    push ecx
    write 1, output_test, 15
    pop ecx
    cmp ecx, 0
    jne print_number_times

exit:
    exit_call 0

exit_bad:
    exit_call 69
