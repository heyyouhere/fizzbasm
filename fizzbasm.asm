%include "syscall.inc"

section .data
    number db 0

section .bss
    input_buff resb 16
    string resb 16
    string_size equ $-string


section .text
    global _start
    input_buff_size db 16
    output_test db "hello, world!", 10, 0
    fizz db "Fizz", 10, 0
    fizz_size equ $-fizz
    basm db "Basm", 10, 0
    fizzbasm db "FizzBasm", 10, 0
    fizzbasm_size equ $-fizzbasm

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
    pop ecx
    cmp edx, 0
    je print_fizzbasm


    mov edx, 0 ; checking if counted div 3 == 0
    mov eax, ecx
    push ecx
    mov ecx, 3
    div ecx
    pop ecx
    cmp edx, 0
    je print_fizz

    mov edx, 0 ; checking if counted div 5 == 0
    mov eax, ecx
    push ecx
    mov ecx, 5
    div ecx
    pop ecx
    cmp edx, 0
    je print_basm

    call print_number
skip_print:
    cmp ecx, [number]
    jne print_number_times


exit:
    exit_call 0

print_fizz:
    push ecx
    write 1, fizz, fizz_size
    pop ecx
    jmp skip_print

print_basm:
    push ecx
    write 1, basm, fizz_size
    pop ecx
    jmp skip_print

print_fizzbasm:
    push ecx
    write 1, fizzbasm, fizzbasm_size
    pop ecx
    jmp skip_print

print_number: ; number in ecx
    mov eax, ecx
    push eax
    mov eax, ecx
    xor ecx, ecx
calculate_len:
    inc ecx
    push ecx
    mov edx, 0
    mov ecx, 10
    div ecx
    pop ecx
    cmp eax, 0
    jne calculate_len
    ; now in ecx is len of number

    pop eax
    mov edx, eax
    push edx
    mov ebx, ecx
    push ebx
next_number:
    dec ecx
    push ecx
    mov edx, 0
    mov ecx, 10
    div ecx
    pop ecx
    add edx, "0"
    mov [string+ecx], dl
    cmp ecx, 0
    jne next_number
    pop ebx
    mov [string+ebx], byte 10
    mov [string+ebx+1], byte 0
    write 1, string, string_size
    ; TODO: when returning ecx is messed up by write; in ecx should be current number we checking
    pop edx
    mov ecx, edx
    ret

exit_error:
    exit_call 69
