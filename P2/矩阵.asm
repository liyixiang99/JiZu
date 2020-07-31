.data
aa:	.space	256	# int aa[8][8]   8*8*4 byte
str_enter:	.asciiz "\n"
str_space:	.asciiz " "
.macro suan(%ans,%i,%j)
	mul %ans,%i,8
	add %ans,%ans,%j
	sll %ans,%ans,2
.end_macro 
.text
	li	$v0,5
	syscall
	move	$s0,$v0	#i
	
	
	li	$v0,5
	syscall
	move	$s1,$v0	#j
	
	
	li	$t0,0
in_i:
		beq $t0,$s0,in_i_end
		li	$t1,0
in_j:
		beq	$t1,$s1,in_j_end
			li	$v0,5
			syscall
			suan($t8,$t0,$t1)
			#mul	$t8,$t0,8	# t8=t0*8
			#add	$t8,$t8,$t1	# t8=t8+t1
			#sll	$t8,$t8,2	# t8=t8<<2=t8*4
			sw	$v0,aa($t8)
			addi	$t1,$t1,1
		j	in_j
in_j_end:
		addi	$t0,$t0,1
	j	in_i
in_i_end:





	li	$t0,0
out_i:
	beq	$t0,$s0,out_i_end
	li	$t1,0
out_j:
	beq	$t1,$s1,out_j_end
	suan($t8,$t0,$t1)
	# mul	$t8,$t0,8	# t8=t0*8
	# add	$t8,$t8,$t1	# t8=t8+t1
	# sll	$t8,$t8,2	# t8=t8<<2=t8*4
	lw	$a0,aa($t8)
	li	$v0,1
	syscall
	la	$a0,str_space
	li	$v0,4
	syscall
	addi	$t1,$t1,1
	j	out_j
out_j_end:
	la	$a0,str_enter
	li	$v0,4
	syscall
	addi	$t0,$t0,1
	j	out_i
out_i_end:
	li $v0,10
	syscall
