.data
	symbol: .space 28
	array: .space 28
	space: .asciiz " "
	enter: .asciiz "\n"
.text
	li $v0,5
	syscall
	move $s0,$v0		# s0 = n
	li $a0,0		# a0 = index
	jal FullArray
	li $v0,10
	syscall
FullArray:
	move $t8,$a0		# t8 = index
	blt $t8,$s0,if_end
	li $t0,0		# i = 0
out:
	beq $t0,$s0,out_end
	mul $t1,$t0,4
	lw $a0,array($t1)
	li $v0,1
	syscall
	la $a0,space
	li $v0,4
	syscall
	addi $t0,$t0,1
	j out
out_end:
	la $a0,enter
	li $v0,4
	syscall
	jr $ra
if_end:
	li $t0,0		# i = 0
for:
	beq $t0,$s0,for_end
	mul $t1,$t0,4
	lw $t2,symbol($t1)
	bne $t2,$0,if2_end
	mul $t1,$t8,4
	addi $t2,$t0,1
	sw $t2,array($t1)
	li $t3,1
	mul $t1,$t0,4
	sw $t3,symbol($t1)
	addi $a0,$t8,1
	# save : i,index,$ra
	addi $sp,$sp,-12
	sw $t0,0($sp)
	sw $t8,4($sp)
	sw $ra,8($sp)
	jal FullArray
	lw $t0,0($sp)
	lw $t8,4($sp)
	lw $ra,8($sp)
	addi $sp,$sp,12
	
	mul $t1,$t0,4
	sw $0,symbol($t1)
if2_end:
	addi $t0,$t0,1
	j for
for_end:
	jr $ra
	