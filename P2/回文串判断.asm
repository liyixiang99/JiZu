.data
	str: .space 20
.text
	li $v0,5
	syscall
	move $s0,$v0
	li $t0,0
loop1:
	beq $s0,$t0,loop1_end
	li $v0,12
	syscall
	sb $v0,str($t0)
	addi $t0,$t0,1
	j loop1	
loop1_end:
	li $t0,0
loop2:
	beq $s0,$t0,yes
	sub $s1,$s0,$t0
	addi $s1,$s1,-1
	lb $t1,str($t0)
	lb $t2,str($s1)
	bne $t1,$t2,no
	addi $t0,$t0,1
	j loop2
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