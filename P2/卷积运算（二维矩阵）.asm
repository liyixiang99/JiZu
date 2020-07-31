.data
	juan: .space 400
	he: .space 400
	space: .asciiz " "
	enter: .asciiz "\n"
.macro suan(%ans,%i,%j)
	mul %ans,%i,10
	add %ans,%ans,%j
	sll %ans,%ans,2
.end_macro 
.text
	li $v0,5
	syscall
	move $s0,$v0		# m1
	li $v0,5
	syscall
	move $s1,$v0		# n1
	li $v0,5
	syscall
	move $s2,$v0		# m2
	li $v0,5
	syscall
	move $s3,$v0		# n2
	
	li $t0,0		# i = 0
in_juan_i:
	beq $t0,$s0,in_juan_i_end	# i<m1
	li $t1,0		# j = 0
in_juan_j:
	beq $t1,$s1,in_juan_j_end	# j<n1
	li $v0,5
	syscall
	suan($t2,$t0,$t1)
	sw $v0,juan($t2)
	addi $t1,$t1,1	# j++
	j in_juan_j
in_juan_j_end:
	addi $t0,$t0,1	# i++
	j in_juan_i
in_juan_i_end:


	li $t0,0		# i = 0
in_he_i:
	beq $t0,$s2,in_he_i_end	# i<m2
	li $t1,0		# j = 0
in_he_j:
	beq $t1,$s3,in_he_j_end	# j<n2
	li $v0,5
	syscall
	suan($t2,$t0,$t1)
	sw $v0,he($t2)
	addi $t1,$t1,1	# j++
	j in_he_j
in_he_j_end:
	addi $t0,$t0,1	# i++
	j in_he_i
in_he_i_end:



	li $t0,0		# i = 0
mul_i:
	sub $t4,$s0,$s2		# m1-m2
	addi $t4,$t4,1		# m1-m2+1
	beq $t0,$t4,mul_i_end	# i<m1-m2+1
	li $t1,0		# j = 0
mul_j:
	sub $t5,$s1,$s3		# n1-n2
	addi $t5,$t5,1		# n1-n2+1
	beq $t1,$t5,mul_j_end	# j<n1-n2+1
	li $s7,0		# sum = 0
	li $t2,0		# k = 0
mul_k:
	beq $t2,$s2,mul_k_end	# k<m2
	li $t3,0		# l = 0
mul_l:
	beq $t3,$s3,mul_l_end	# l<n2
	add $t6,$t0,$t2		# i+k
	add $t7,$t1,$t3		# j+l
	suan($t8,$t6,$t7)
	lw $s4,juan($t8)
	suan($t9,$t2,$t3)
	lw $s5,he($t9)
	mul $s6,$s4,$s5		# juan[][]*he[][]
	add $s7,$s7,$s6
	addi $t3,$t3,1	# l++
	j mul_l
mul_l_end:
	addi $t2,$t2,1	# k++
	j mul_k
mul_k_end:
	move $a0,$s7
	li $v0,1
	syscall
	la $a0,space
	li $v0,4
	syscall
	addi $t1,$t1,1	# j++
	j mul_j
mul_j_end:
	la $a0,enter
	li $v0,4
	syscall
	addi $t0,$t0,1	# i++
	j mul_i
mul_i_end:
	li $v0,10
	syscall
