.data
	juan: .space 400
	he: .space 400
	space: .asciiz " "
	enter: .asciiz "\n"

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
	
	 
	
	li $t0,0		# i
int_juan:
	mul $t1,$s0,$s1		# $t1 = m1*n1
	beq $t0,$t1,int_juan_end
	li $v0,5
	syscall
	mul	$t2,$t0,4
	sw $v0,juan($t2)
	addi $t0,$t0,1
	j int_juan
int_juan_end:
	li $t0,0		# i
int_he:
	mul $t1,$s2,$s3		# $t1 = m2*n2
	beq $t0,$t1,int_he_end
	li $v0,5
	syscall
	mul	$t2,$t0,4
	sw $v0,he($t2)
	addi $t0,$t0,1
	j int_he
int_he_end:
	
	
	li $t0,0		# i
mul_i:
	sub $s4,$s0,$s2
	addi $s4,$s4,1
	beq $t0,$s4,mul_i_end	# i<m1-m2+1
	li $t1,0		# j
mul_j:
	sub $s5,$s1,$s3
	addi $s5,$s5,1
	beq $t1,$s5,mul_j_end	# j<n1-n2+1
	li $t4,0		#sum
	li $t2,0		# k
mul_k:
	beq $t2,$s2,mul_k_end	# k<m2
	li $t3,0		#l
mul_l:
	beq $t3,$s3,mul_l_end	# l<n2
	
	add $t5,$t0,$t2		# k+i
	mul $t5,$t5,$s1		# *n1
	add $t5,$t5,$t3		# +l
	add $t5,$t5,$t1		# +j
	mul $t5,$t5,4		# *4
	lw $t6,juan($t5)		# juan[]
	mul $t7,$s3,$t2		# n2*k
	add $t7,$t7,$t3		# +l
	mul $t7,$t7,4
	lw $t8,he($t7)	# he[]
	mul $t9,$t6,$t8
	add $t4,$t9,$t4	# $s4 = sum
	addi $t3,$t3,1	# l++
	j mul_l
mul_l_end:
	addi $t2,$t2,1	# k++
	j mul_k
mul_k_end:
	move $a0,$t4
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
