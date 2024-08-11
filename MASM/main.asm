.386                ; Specify instruction set
.model flat, stdcall ; Flat memory model, standard calling convention
.stack 4096         ; Reserve stack space
ExitProcess PROTO, dwExitCode: DWORD  ; Exit process prototype

.data               ; Data segment
A BYTE 3,2,3,1,7,5,0,8,9,2       ; Array A with 10 elements (BYTE size)
B BYTE 10 DUP(0)                 ; Array B with 10 elements, initialized to 0 (BYTE size)
i BYTE 0                         ; Loop counter variable (BYTE size)

.code              ; Code segment
main PROC          ; Main procedure

    mov ecx, 0     ; Initialize loop counter to 0

loop_start:
    cmp ecx, 10    ; Compare loop counter with 10
    jge loop_end   ; If counter >= 10, exit loop

    ; Calculate 2 * i
    mov eax, ecx   ; Move loop counter (i) into eax
    add eax, eax   ; eax = 2 * i

    ; Calculate (3 * i + 1)
    mov ebx, ecx   ; Move loop counter (i) into ebx
    imul ebx, ebx, 3 ; ebx = 3 * i
    add ebx, 1     ; ebx = 3 * i + 1

    ; Divide (3 * i + 1) by 5
    mov edx, 0     ; Clear edx for division
    div ebx        ; eax = (3 * i + 1) / 5

    ; Add the results from Step 1 and Step 3
    add eax, ecx   ; eax = 2 * i + (3 * i + 1) / 5

    ; Multiply the result by 2
    add eax, eax   ; eax = 2 * (2 * i + (3 * i + 1) / 5)

    ; Add A[i]
    movzx ebx, BYTE PTR [A + ecx] ; Load A[i] into ebx (BYTE size)
    add eax, ebx   ; eax = A[i] + 2 * (2 * i + (3 * i + 1) / 5)

    ; Store the result in B[i]
    mov [B + ecx], al ; Store result in B[i] (BYTE size)

    ; Increment loop counter
    add ecx, 1     ; i++

    jmp loop_start ; Repeat the loop

loop_end:
    INVOKE ExitProcess, 0 ; Exit the program

main ENDP          ; End of main procedure
END main           ; End of the program
