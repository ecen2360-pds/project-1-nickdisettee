atoi:
    movia r4, 0xff201000
	addi  sp, sp, -8
    stw   ra, 4(sp)
    mov   r2, r0        # sum = 0
    mov   r8, r0        # negate = 0
    ldb   r3, 0(r4)     # load first character from string input in r4
    movi  r9, 0x2D		# ascii for '-' negative sign
    beq   r3, r9, atoi_neg	# branch if first char is '-'

atoi_loop:
    movi  r9, 0x30     			
    movi  r10, 0x39    
    blt   r3, r9, atoi_done
    bgt   r3, r10, atoi_done	# branch if not a digit

    sub   r3, r3, r9   			# convert to actual digit
    muli  r2, r2, 10			# multiply current ongoing value by 10
    add   r2, r2, r3			# add new digit on
	ldb   r3, 0(r4)
    br    atoi_loop

atoi_neg:
    movi  r8, 1
    addi  r4, r4, 1
    br    atoi_loop

atoi_done:
    beq   r8, r0, atoi_ret
    sub   r2, r0, r2    #apply negative

atoi_ret:
    ldw   ra, 4(sp)
    addi  sp, sp, 8
    ret
