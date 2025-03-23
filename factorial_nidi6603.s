#n in r4

FACTORIAL:
    addi r2, r0, 1
    addi r3, r0, 1

LOOP:
    bgt r4, r3, MULTIPLY
    ret

MULTIPLY:
    mul r2, r2, r4
    addi r4, r4, -1
    br LOOP
