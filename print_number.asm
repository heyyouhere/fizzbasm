%include "syscall.inc"


section .bss
    string resb 16
    string_size equ $-string


section .text
    global _start

_start:
    mov eax, 123405

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


    mov eax, 42690

    dec ecx
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

    exit_call 0

bad_exit:
    exit_call 10
