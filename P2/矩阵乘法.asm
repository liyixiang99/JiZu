.data
aa: .space 256
bb: .space 256
cc: .space 256
space: .asciiz " "
enter: .asciiz "\n"
.macro suan(%ans,%i,%j)
	mul %ans,%i,8
	add %ans,%ans,%j
	sll %ans,%ans,2
.end_macro
.text
	li $v0,5
	syscall
	move $s0,$v0
	li $t0,0		#a_i
in_a_i:
	beq $s0,$t0,in_a_i_end	#a_i<n
	li $t1,0		#a_j
in_a_j:
	beq $s0,$t1,in_a_j_end	#a_j<n
	li $v0,5
	syscall
	suan($t2,$t0,$t1)
	sw $v0,aa($t2)	
	addi $t1,$t1,1	#a_j++
	j in_a_j
in_a_j_end:
	addi $t0,$t0,1	#a_i++
	j in_a_i
in_a_i_end:


	
	li $t0,0		#b_i
in_b_i:
	beq $s0,$t0,in_b_i_end	#b_i<n
	li $t1,0		#b_j
in_b_j:
	beq $s0,$t1,in_b_j_end	#b_j<n
	li $v0,5
	syscall
	suan($t2,$t0,$t1)
	sw $v0,bb($t2)	
	addi $t1,$t1,1	#b_j++
	j in_b_j
in_b_j_end:
	addi $t0,$t0,1	#b_i++
	j in_b_i
in_b_i_end:



	li $t0,0		#i
mul_i:
	beq $t0,$s0,mul_i_end
	li $t1,0		#j
mul_j:
	beq $t1,$s0,mul_j_end
	li $t2,0		#k
	li $t3,0		#sum
mul_k:
	beq $t2,$s0,mul_k_end
	#sum = sum + aa[i][k] * bb[k][j]
	suan($t4,$t0,$t2)	#$t4 = (i*8+k)*4
	suan($t5,$t2,$t1)	#$t5 = (k*8+j)*4
	lw $t4,aa($t4)		#$t4 = aa[i][k]
	lw $t5,bb($t5)		#$t5 = bb[k][j]
	mul $t4,$t4,$t5		#$t4 = $t4*$t5
	add $t3,$t3,$t4		#$t3 = $t3+$t4
	addi $t2,$t2,1
	j mul_k
mul_k_end:
	suan($t6,$t0,$t1)
	sw $t3,cc($t6)		#cc[i][j]= $t3
	addi $t1,$t1,1
	j mul_j
mul_j_end:
	addi $t0,$t0,1
	j mul_i
mul_i_end:



	li $t0,0		#i
out_i:
	beq $t0,$s0,out_i_end
	li $t1,0		#j
out_j:
	beq $t1,$s0,out_j_end
	suan($t2,$t0,$t1)	#$t2 = (i*8+j)*4
	lw $a0,cc($t2)		#$a0 = c[i][j]
	li $v0,1
	syscall
	la $a0,space
	li $v0,4
	syscall
	addi $t1,$t1,1		#j++
	j out_j
out_j_end:
	la $a0,enter
	li $v0,4
	syscall
	addi $t0,$t0,1		#i++
	j out_i
out_i_end:
	li $v0,10
	syscall
