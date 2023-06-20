%include "./utils/printf32.asm"
extern printf
section .data
    temp_len dd 8
    temp_1 dd 5, 7, -2, 10, -4, 2, 3, 0
    temp_2 dd 1, 3, 0, -1, -1, 2, 3, 5

section .bss
    ; TODO a: Reserve space for merged_temp
merged_temp resd 16

section .text
global main

main:
    push ebp
    mov ebp, esp

    xor ecx, ecx
    xor edx, edx
looper_merge:
    cmp ecx, 8
    je over
    mov eax, dword [temp_1 + ecx*4]
    PRINTF32 `%d %d\n\x0`, eax, ebx
    mov [merged_temp + ecx*4], eax
    PRINTF32 `vector %d \n\x0`, dword [merged_temp + ecx*4]
    inc ecx
    ;mov [merged_temp + ecx*4], ebx 
   ; PRINTF32 `vixtor %d \n\x0`, dword [merged_temp + ecx*4]
   ; inc ecx
    jmp looper_merge
over:
;xor ecx, ecx
xor edx, edx
looper_merge2:
    cmp edx, 8
    je over2
    mov eax, dword [temp_2 + edx*4]
    PRINTF32 `%d \n\x0`, eax
    mov [merged_temp + ecx*4], eax
    PRINTF32 `vector %d \n\x0`, dword [merged_temp + ecx*4]
    inc edx
    inc ecx
    ;mov [merged_temp + ecx*4], ebx 
   ; PRINTF32 `vixtor %d \n\x0`, dword [merged_temp + ecx*4]
   ; inc ecx
    jmp looper_merge2 

    ; TODO a: Populate and print merged_temp


    ; TODO b: Get minimum value from the vector
over2:
xor ecx, ecx
loop_print:
    cmp ecx, 17
    je gata1
    PRINTF32 `%d \x0`, dword [merged_temp + ecx*4]
    inc ecx
    jmp loop_print
  gata1:     ; TODO c: Get number of values >= 0
 ; Return 0.
xor ecx, ecx
xor edx, edx
mov edx, 11
parcurg_merge:
    cmp ecx, 17
    je bye
    mov eax, dword [merged_temp + ecx*4]
    cmp edx, eax
    jg min
    inc ecx
    jmp parcurg_merge


min:
    PRINTF32 `MIN \n%d \x0`,eax
    mov ebx, eax 
    mov edx, eax
    inc ecx
    jmp parcurg_merge



    ; TODO d: Reverse the merged_temp array

bye:
 PRINTF32 `MIN FIN %d \x0`,ebx
    ; TODO c: Get number of values >= 0
xor ecx, ecx
xor edx, edx
xor ebx,ebx
alt_looper_nrz:
    cmp ecx, 17
    je done
    mov eax, dword [merged_temp + ecx*4]
    cmp eax, 0
    jg nr_zero
    inc ecx
    jmp alt_looper_nrz

nr_zero:
    inc ebx
    inc ecx
    jmp alt_looper_nrz
done:
 PRINTF32 `MAI MARi CA ZERO %d \n\x0`,ebx

 xor ecx, ecx
 xor edx, edx
 xor ebx, ebx
 looper_pt_push:
    cmp ecx, 17
    je label2
    mov eax, dword [merged_temp + ecx*4]
    push eax
    inc ecx
    jmp looper_pt_push
label2:
    xor ecx, ecx
looper_pt_pop:
    cmp ecx, 17
    je arivederci
    pop eax
    mov [merged_temp + ecx*4], eax
    inc ecx
    jmp looper_pt_pop
arivederci:
xor ecx, ecx
printer2:
    cmp ecx, 17
    je lol
     PRINTF32 ` %d \x0`, dword [merged_temp + ecx*4]
     inc ecx
     jmp printer2
    
lol:
    xor eax, eax
    leave
    ret
