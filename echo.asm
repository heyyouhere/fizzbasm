%include "syscall.inc"

section .data
    counter db 1

section .bss
    echo_buffer resb 1024


section .text
    global _start
    message db "Hello, world!", 10, 0
    extra db "Exiting!", 10, 0
 _start:
    read 0, echo_buffer, 1024
    mov ebp, eax ; Saving amount of bytes read
    write 1, echo_buffer, ebp
    exit 0
