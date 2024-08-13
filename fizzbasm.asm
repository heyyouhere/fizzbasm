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
    fizzbasm db "FizzBasm", 10, 0

_start:
    mov dword [number], 0      ; save number
    read 0, input_buff, input_buff_size
    jmp parse_number

parse_number:
    mov ecx, 0
    dec eax                    ; remove newline

parse_digit:
    mov bl, [input_buff + ecx] ; get the byte of the char
    sub bl, "0"                ; get the int from the char
    push eax                   ; save amount of char read
    mov eax, [number]          ; load current value of number
    imul eax, 10               ; multiply it by 10; first one is 0*10
    add eax, ebx               ; add current digit
    mov [number], eax          ; save number
    pop eax                    ; restore amount of items
    inc ecx                    ; dec counter
    cmp ecx, eax               ; check if some left
    jne parse_digit
    mov cx, 0

print_number_times:
    inc ecx

    mov edx, 0                  ; checking if counted div 15 == 0
    mov eax, ecx
    push ecx
    mov ecx, 15
    div ecx
    cmp edx, 0
    je print_fizzbasm

    pop ecx                     ; checking if counted div 3 == 0
    mov edx, 0
    mov eax, ecx
    push ecx
    mov ecx, 3
    div ecx
    cmp edx, 0
    je print_fizz

    pop ecx                     ; checking if counted div 5 == 0
    mov edx, 0
    mov eax, ecx
    push ecx
    mov ecx, 5
    div ecx
    cmp edx, 0
    je print_basm


    write 1, output_test, 15    ; TODO: make it print a int, not a default string
skip_print:
    pop ecx
    cmp ecx, [number]
    jne print_number_times


exit:
    exit_call 0

print_fizz:
    write 1, fizz, 6
    jmp skip_print

print_basm:
    write 1, basm, 6
    jmp skip_print

print_fizzbasm:
    write 1, fizzbasm, 10
    jmp skip_print

exit_error:
    exit_call 69
