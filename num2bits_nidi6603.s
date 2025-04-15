# Verified 

.global num2bits

# num stored in r4
num2bits:
	addi    sp, sp, -28
    
    stw     ra, 24(sp)      # prologue
    stw     r21, 20(sp)
    stw     r20, 16(sp)
    stw     r19, 12(sp)
    stw     r18, 8(sp)
    stw     r17, 4(sp)
    stw     r16, 0(sp)

    movi    r19, 0
    movi    r20, 0

    addi    r16, r0, 9999
    bgt     r4, r16, num2bits_err
    blt     r4, r0, num2bits_err

digit_loop:
    addi    r17, r0, 10
    div     r21, r4, r17
    mul     r18, r21, r17
    sub     r18, r4, r18
    ldbu    r16, Bits7seg(r18)
    muli    r17, r20, 8
    sll     r16, r16, r17
    add     r19, r19, r16
    addi    r20, r20, 1
    beq     r21, r0, num2bits_end
    mov     r4, r21
    br      digit_loop

num2bits_err:
    addi    r19, r0, 0x4040 
    slli    r19, r19, 16
    addi    r19, r19, 0x4040

num2bits_end:
    add     r2, r19, r0     # put return value in r2
    
    ldw     ra, 24(sp)      # epilogue
    ldw     r21, 20(sp)
    ldw     r20, 16(sp)
    ldw     r19, 12(sp)
    ldw     r18, 8(sp)
    ldw     r17, 4(sp)
    ldw     r16, 0(sp)
    
    addi    sp, sp, 28
    ret

.data
Bits7seg:
    .byte   0x3F,0x06,0x5B,0x4F,0x66,0x6D,0x7D,0x07,0x7F,0x6F
