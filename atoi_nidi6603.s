.text
.global _start

_start:
    movia r8, 0xFF201000       # JTAG address
    movia r9, 0x1000           # buffer at 0x1000
    call JTAG_START
    movia r8, 0x1000
    call ATOI
    br end

JTAG_START:
    addi r10, r0, 0

READ_LOOP:
    ldwio r11, 4(r8)           # JTAG UART status register
    andi r11, r11, 0x8000      # check if data is valid
    beq r11, r0, READ_LOOP

    ldwio r12, 0(r8)           # read char in JTAG UART
    stb r12, 0(r9)             # store char in buffer
    addi r9, r9, 1
    addi r10, r10, 1
    movi r13, 0x0A             # \n TODO: *DOUBLE CHECK THIS PART* 
    beq r12, r13, READ_DONE
    br READ_LOOP

READ_DONE:
    movi r12, 0
    stb r12, 0(r9)
    ret

ATOI:
    addi r2, r0, 0
    addi r3, r0, 0
    ldbu r4, 0(r8)             # load first character
    movi r5, 0x2D              # -
    bne r4, r5, LOOP
    movi r3, 1
    addi r8, r8, 1
LOOP:
    ldbu r4, 0(r8)
    beq r4, r0, DONE
    movi r5, 0x30 
    blt r4, r5, DONE      # exit if <0
    movi r5, 0x39
    bgt r4, r5, DONE      # exit if >9

    subi r4, r4, 0x30          # convert
    muli r2, r2, 10
    add r2, r2, r4 
    addi r8, r8, 1
    br LOOP
DONE:
    beq r3, r0, END
    sub r2, r0, r2
END:
    ret
