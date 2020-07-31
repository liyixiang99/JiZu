.data
	ab: .space 10000
	space: .asciiz " "
	enter: .asciiz "\n"
.macro suan(%ans,%i,%j)
	mul %ans,%i,50
	add %ans,%ans,%j
	sll %ans,%ans,2
.end_macro 
.text
	li $v0,5
	syscall
	move $s0,$v0		# n
	li $v0,5
	syscall
	move $s1,$v0		# m
	li $t0,0		# i
in_i:
	beq $t0,$s0,in_i_end		#i<n
	li $t1,0		# j
in_j:
	beq $t1,$s1,in_j_end		#j<m
	li $v0,5
	syscall
	suan($t2,$t0,$t1)
	sw $v0,ab($t2)
	addi $t1,$t1,1	# j++
	j in_j
in_j_end:
	addi $t0,$t0,1	# i++
	j in_i
in_i_end:
	li $t0,0		# i
	add $t0,$t0,$s0	# i = n
	addi $t0,$t0,-1 # i = n-1 
find_i:
	blt $t0,$0,find_i_end	# i>=0
	li $t1,0		# j
	add $t1,$t1,$s1	# j = m
	addi $t1,$t1,-1 # j = m-1 
find_j:
	blt $t1,$0,find_j_end	# j>=0
	suan($t2,$t0,$t1)
	lw $t3,ab($t2)
	bne $t3,$0,out
	addi $t1,$t1,-1	# j--
	j find_j
find_j_end:
	addi $t0,$t0,-1	# i--
	j find_i
out:
	move $a0,$t0
	addi $a0,$a0,1	#print hang
	li $v0,1
	syscall
	la $a0,space		#print space
	li $v0,4
	syscall
	move $a0,$t1
	addi $a0,$a0,1	#print lie
	li $v0,1
	syscall
	la $a0,space		#print space
	li $v0,4
	syscall
	move $a0,$t3		#print [][]
	li $v0,1
	syscall
	la $a0,enter		#print enter
	li $v0,4
	syscall
	addi $t1,$t1,-1	# j--
	j find_j
find_i_end:
	li $v0,10
	syscall



	
	
	
	
	
	
