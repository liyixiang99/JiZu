# ori
ori $a0,$0,0x1234 # a0=0x1234
ori $a1,$a0,0x4321 # a1=0x5335
# nop
nop
# lui
lui $a2,0x2333 # a2=0x23330000
lui $a3,0xffff # a3=0xffff0000
ori $a3,$a3,0xffff # a3=0xffffffff,-1
# addu
addu $s0,$a0,$a2 #   s0=0x23331234
addu $s1,$a0,$a3 #  s1=0x00001233
addu $s2,$a3,$a3 #  s2=0xfffffffe
# subu
subu $s3,$a0,$a2 #  $a0<$a2,s3=dccd1234
subu $s4,$a2,$a0 #  $a2>$a0,s4=2332edcc
subu $s5,$a0,$a3 #  s5=00001235
subu $s6,$a3,$a0 #  s6=ffffedcb
subu $s7,$a3,$a3 #  s7=00000000
# sw
ori $t8,$0,0x0008 # t8=0x0008
sw $a0,-8($t8) # mem[0]=0x00001234
sw $a1,-4($t8) # mem[4]=0x00005335
sw $a2,0($t8) # mem[8]=0x23330000
sw $a3,4($t8) # mem[12]=0xffffffff
# lw
lw $t0,-8($t8) # t0=0x00001234
lw $t1,-4($t8) # t1=0x00005335
lw $t2,0($t8) # t2=0x23330000
lw $t3,4($t8) # t3=0xffffffff
# beq
beq $a0,$t8,label1 # != 
beq $a0,$t0,label2 #  =
label1: ori $t4,$0,0x8888 # no run
label2: ori $t5,$0,0x9999