extern printf

section .data

fmt_int db "%d ", 0
fmt_newline db  10,0
fmt_time db "%d:%d:%d", 10, 0

seconds_int dd 86399
seconds_arr dd 0, 60, 61, 3661, 7322, 10983, 14644, 18305, 21966, 86399
len equ 10

section .bss

ss_t resd 1
mm_t resd 1
hh_t resd 1

section .text
global main

;TODO a: Implement `void print_array(int *arr, int len)` function:
; that prints the all `len` integer elements of array `arr` on the same line separated by a space.
; print a new line at the end.
; It is mandatory to use `printf` for printing. You may use `fmt_int` and `fmt_newline` for formatting.

print_array:
    push ebp
    mov ebp, esp

    mov eax, [ebp+8]
    mov edx, [ebp + 12]

    xor ecx, ecx
looper_printer:
    cmp ecx, edx
    je gata

    push eax
    push edx
    push ecx

    mov ebx , dword [eax + 4*ecx]
    push ebx
    push fmt_int
    call printf
    add esp, 8

    pop ecx
    pop edx
    pop eax
    inc ecx
    jmp looper_printer
gata:
    leave
    ret

; TODO b: Implement `void convert_time(int s, int *hh, int *mm, int *ss)` function
; that converts an amount of `s` seconds into (hh, mm, ss) format where:
; hh: is the number of hours that can be found in `s`
; mm: is the number of minutes left in `s` after substracting the hours `hh`
; ss: is the number of seconds left in `s` after substracting the hours `hh` and minutes `mm`
; e.g:
; convert_time(0, &hh, &mm, &ss)    => (0, 0, 0)
; convert_time(61, &hh, &mm, &ss)   => (0, 1, 1)
; convert_time(3661, &hh, &mm, &&ss) => (1, 1, 1)

; NOTE: For `div` instruction one can place the dividend in `edx:eax`, divisor in register or memory
; and the result be placed like this: Quotient in EAX, Remainder in EDX

convert_time:
    push ebp
    mov ebp, esp
    
    mov eax, [ebp + 8]
    mov ebx, [ebp + 12]
    mov ecx, [ebp + 14]
    mov edx, [ebp + 16]
    mov edi ,[ebp + 18] 
    

    ; div 60
    push ebx;
    push ecx
    push edx
    push edi 
    xor edx, edx
    mov ebx, 3600
    div ebx
    mov edi, eax
    ;push eax
   ; push edx ; e bine da 12 ore eax
   ; push fmt_int
    ;call printf
   ; add esp, 8

    ;pop edx
    pop ebx
   ; pop ecx
    ;pop edi
    
    mov ebx, eax
    push ebx
   xor eax, eax
    mov eax, edx
    xor edx, edx
    xor ebx, ebx
    mov ebx, 60
    div ebx

   ; push eax ; 
   ; push fmt_int
   ; call printf
   ; add esp, 8

    pop ebx
    pop ecx
    mov ecx, eax
    pop edi
    mov edi, edx

    pop eax

    mov [ss_t], edi
    mov [mm_t], ecx
    mov [hh_t], ebx
     
   ; push edi
   ; push  ecx
   ; push  ebx
    ;push fmt_time
   ; call printf
   ; add esp, 16


    leave
    ret

main:
    push ebp
    mov ebp, esp

    ; TODO a: print `seconds_arr` array by calling print_array(seconds_arr, len)
    ; `seconds_arr` and `len` are defined in `.data` section

    push len
    push seconds_arr
    call print_array
    add esp, 8

    push fmt_newline
    call printf
    add esp, 8

    ; TODO b: compute the number of (hh, mm, ss) to be found in `seconds_int` by calling `convert_time` function
    ; Use `ss_t`, `mm_t`, `hh_t` memory areas to store the result.
    ; Use `printf` to display the result. Use `fmt_time` for formatting
    push dword [ss_t]
    push dword [mm_t]
    push dword  [hh_t]
    push dword [seconds_int]
    call convert_time
    add esp,16


    push dword [ss_t]
    push dword [mm_t]
    push dword [hh_t]
    push fmt_time
    call printf
    add esp, 16
    ; TODO c: Convert all `len` elements of `seconds_arr` to (hh, mm, ss) format and display the result
    ; For each element, store the result in `ss_t`, `mm_t`, `hh_t` memory areas
    ; and then print it before moving to the nexte element
    ; Use `printf` to display the result. Use `fmt_time` for formatting
    xor ecx, ecx
converter:
    cmp ecx, len
    je doner
    mov dword [ss_t] , 0
    mov dword [ mm_t], 0
    mov dword [hh_t], 0
    mov eax, dword [seconds_arr + ecx*4]
    push ecx
    push dword [ss_t]
    push dword [mm_t]
    push dword [hh_t]
    push eax
    call convert_time
  add esp, 16

  push dword [ss_t]
    push dword [mm_t]
    push dword [hh_t]
    push fmt_time
    call printf
    add esp, 16
  pop ecx
  inc ecx
  jmp converter


doner:  ; Return 0.

    xor eax, eax
    leave
    ret
