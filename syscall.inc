%macro syscall 0
    int 0x80
%endmacro

%macro exit_call 1
    mov eax, 1
    mov ebx, %1
    syscall
%endmacro

%macro write 3
     mov eax, 4
     mov ebx, %1
     mov ecx, %2
     mov edx, %3
     syscall
%endmacro

%macro read 3
    mov eax, 3
    mov ebx, %1
    mov ecx, %2
    mov edx, %3
    syscall
%endmacro
