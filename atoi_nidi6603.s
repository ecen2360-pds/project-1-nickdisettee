# Verified

.global atoi

# put JTAG UART address into r4
# r2 is the return value
atoi:
    addi  sp, sp, -8
    stw   ra, 4(sp)

    mov   r2, r0
    mov   r8, r0

    ldb   r3, 0(r4)
    movi  r9, 0x2D
    beq   r3, r9, atoi_neg

atoi_loop:

    ldb   r3, 0(r4)
    movi  r9, 0x30     
    movi  r10, 0x39  
	
    blt   r3, r9, atoi_done
    bgt   r3, r10, atoi_done
	
    sub   r3, r3, r9   
    muli  r2, r2, 10
    add   r2, r2, r3
    addi  r4, r4, 1
    br    atoi_loop

atoi_neg:
    movi  r8, 1
    addi  r4, r4, 1
    br    atoi_loop

atoi_done:
    beq   r8, r0, atoi_ret
    sub   r2, r0, r2

atoi_ret:
    ldw   ra, 4(sp)
    addi  sp, sp, 8
    ret
