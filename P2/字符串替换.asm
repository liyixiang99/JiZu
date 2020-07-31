.data
	str1: .space 100
	str2: .space 100
	str3: .space 100
.text
	li $v0,5
	syscall
	move $s0,$v0		# n1
	li $v0,5
	syscall
	move $s1,$v0		# n2
	li $v0,5
	syscall
	move $s2,$v0		# n3
	li $t0,0		# i = 0
in_1:
	beq $t0,$s0,in_1_end
	li $v0,12
	syscall
	sb $v0,str1($t0)
	addi $t0,$t0,1
	j in_1
in_1_end:
	li $t0,0		# i = 0
in_2:
	beq $t0,$s1,in_2_end
	li $v0,12
	syscall
	sb $v0,str2($t0)
	addi $t0,$t0,1
	j in_2
in_2_end:
	li $t0,0		# i = 0
in_3:
	beq $t0,$s2,in_3_end
	li $v0,12
	syscall
	sb $v0,str3($t0)
	addi $t0,$t0,1
	j in_3
in_3_end:
	li $t0,0		# i = 0
while:
	beq $t0,$s0,while_end
	li $t2,1		# flag = 1
	li $t1,0		# j = 0
for:
	beq $t1,$s1,for_end
	add $t3,$t0,$t1
	lb $t4,str1($t3)
	lb $t5,str2($t1)
	bne $t4,$t5,if_end
	addi $t1,$t1,1
	j for
if_end:
	li $t2,0
	j for_end
for_end:
	beq $t2,1,loop1
	lb $a0,str1($t0)
	li $v0,11
	syscall
	addi $t0,$t0,1
	j while
loop1:
	la $a0,str3
	li $v0,4
	syscall
	add $t0,$t0,$s1
	j while
while_end:
