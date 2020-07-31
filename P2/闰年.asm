.text
	li $v0,5
	syscall
	move $s0,$v0
	li $s1,4
	li $s2,100
	li $s3,400
	div  $s0,$s3
	mfhi $t0		# s0%400
	beq $t0,$0,yes
	div  $s0,$s1
	mfhi $t1		# s0%4
	bne $t1,$0,no
	div $s0,$s2
	mfhi $t3		# s0%100
	beq $t3,$0,no
	bne $t3,$t0,yes
yes:
	li $a0,1
	li $v0,1
	syscall
	li $v0,10
	syscall
no:
	li $a0,0
	li $v0,1
	syscall
	li $v0,10
	syscall