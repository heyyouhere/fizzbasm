%include "syscall.inc"



section .data
    number db 0

section .bss
    input_buff resb 16

section .text
    global _start
    input_buff_size db 16
    test_string db "5"
    output_test db "hello, world!", 10, 0

_start:
    ;Read amount of elements to print
    ; read 0, input_buff, input_buff_size
    ; mov [number], db 0
    mov dword [number], 0 ; save number
    jmp parse_number
    ; write 1, input_buff, input_buff_size
    ; parse bytes into number
    ; iter from 1 to number
    ;Print "Fizz" if mod 3
    ;Print "Buzz" if mod 5
    ;Print "FizzBuzz" if mod 15
parse_number:
    mov ecx, 0

parse_digit:
    mov bl, [test_string + ecx] ; get the byte of the char
    sub bl, "0" ; get the int from the char
    mov eax, [number] ; load current value of number
    imul eax, 10 ; multiply it by 10
    add eax, ebx ; add current digit
    mov [number], eax ; save number
    inc ecx ; dec counter
    cmp ecx, 1 ; check if some left
    jnz parse_digit
    mov ecx, [number]

print_number_times:
    dec ecx
    write 1, output_test, 15
    cmp ecx, 0
    jne print_number_times

finish:
    exit 0
finish_bad:
    exit 24


    ;; Битрикс
    ;; 1C CRM
    ;; Amo CRM
