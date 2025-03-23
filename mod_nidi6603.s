MOD:
    addi sp, sp, -8
    stw r8, 0(sp)
    stw r9, 4(sp)
    
    div r8, r4, r5
    mul r9, r8, r5
    sub r9, r4, r9     

    addi r2, r9, 0
    
    ldw r8, 0(sp)
    ldw r9, 4(sp)

    ret
