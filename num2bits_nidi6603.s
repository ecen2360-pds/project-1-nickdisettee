.data
Bits7seg:
    .byte 0x3F  # 0
    .byte 0x06  # 1
    .byte 0x5B  # 2
    .byte 0x4F  # 3
    .byte 0x66  # 4
    .byte 0x6D  # 5
    .byte 0x7D  # 6
    .byte 0x07  # 7
    .byte 0x7F  # 8
    .byte 0x6F  # 9

.text
.global _start

num2bits_nonrecursive:
    # Input: r3 = number (0-9999)
    # Output: r2 = 7-segment bit pattern

    addi r2, r0, 0          # r2 = 0 (initialize output)
    addi r4, r0, 0          # r4 = 0 (counter)
    addi r5, r0, 10         # r5 = 10 (for division)

extract_digits:
    div r6, r3, r5          # r6 = r3 / 10 (quotient)
    mul r7, r6, r5          # r7 = r6 * 10
    sub r8, r3, r7          # r8 = r3 - r7 (remainder, i.e., the digit)
    ldbu r9, Bits7seg(r8)   # r9 = 7-segment bit pattern for the digit
    slli r2, r2, 8          # Shift r2 left by 8 bits
    or r2, r2, r9           # Combine the new digit with the existing bits
    add r3, r0, r6          # r3 = quotient for next iteration
    addi r4, r4, 1          # Increment counter
    bne r3, r0, extract_digits # If quotient != 0, continue extracting digits

    ret                     # Return with r2 containing the bit pattern

num2bits_recursive:
    # Input: r3 = number (0-9999)
    # Output: r2 = 7-segment bit pattern

    addi r5, r0, 10         # r5 = 10 (for division)
    blt r3, r5, single_digit # If r3 < 10, handle as a single digit

    # Recursive case
    div r6, r3, r5          # r6 = r3 / 10 (quotient)
    mul r7, r6, r5          # r7 = r6 * 10
    sub r7, r3, r7          # r7 = r3 - r7 (remainder, i.e., the digit)
    subi sp, sp, 4          # Allocate space on the stack
    stw r7, 0(sp)           # Save the remainder (digit) on the stack
    call num2bits_recursive  # Recursively call the function with the quotient
    ldw r7, 0(sp)           # Restore the remainder (digit) from the stack
    addi sp, sp, 4          # Deallocate space from the stack
    ldbu r8, Bits7seg(r7)   # r8 = 7-segment bit pattern for the digit
    slli r2, r2, 8          # Shift r2 left by 8 bits
    or r2, r2, r8           # Combine the new digit with the existing bits
    ret

single_digit:
    ldbu r2, Bits7seg(r3)   # r2 = 7-segment bit pattern for the single digit
    ret
