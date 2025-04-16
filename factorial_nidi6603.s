# Verified
# N in r4
.global factorial
factorial:
    addi  sp, sp, -4
    stw   ra, 0(sp)
    movi  r2, 1

factorial_loop:
    beq   r4, r0, factorial_end
    mul   r2, r4, r2
    addi  r4, r4, -1
    br    factorial_loop

factorial_end:
    ldw   ra, 0(sp)
    addi  sp, sp, 4
    ret
