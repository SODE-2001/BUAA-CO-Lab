ori $zero,$0,1234
ori $v0,$0,1234
ori $v1,$0,1234
ori $a0,$0,1234
ori $a1,$0,1234
ori $a2,$0,1234
ori $a3,$0,1234
ori $t0,$0,1234
ori $t1,$0,1234
ori $t2,$0,1234
ori $t3,$0,1234
ori $t5,$0,1234
ori $t6,$0,1234
ori $t7,$0,1234
ori $s0,$0,1234
ori $s1,$0,1234
ori $s2,$0,1234
ori $s3,$0,1234
ori $s4,$0,1234
ori $s5,$0,1234
ori $s6,$0,1234
ori $s7,$0,1234
ori $t8,$0,1234
ori $t9,$0,1234
ori $s1,$t6,134
addu $v1,$s0,$s2
lui $t1,77
ori $t7,$t7,134
subu $t3,$s1,$t6
lui $t0,16
ori $t7,$t8,4321
subu $zero,$s5,$s7
jal label0
addu $zero,$s2,$s2
lui $s6,77
ori $s7,$v1,77
addu $a2,$s5,$t9
lui $t8,5542
ori $t9,$a2,4321
subu $s7,$s3,$a3
lui $s6,4321
ori $t6,$v1,134
subu $s3,$a2,$a2
label0:
lui $t0,2
ori $t6,$s5,1
subu $a0,$t1,$zero
lui $s1,16
ori $t1,$t2,77
addu $t9,$s1,$t5
jr $ra
subu $s1,$v0,$a0
lui $t5,134
ori $s6,$s5,-233
addu $s0,$s2,$t7
jal label1
lui $a1,4321
ori $s1,$v0,0
addu $t0,$a0,$t6
lui $t0,5542
ori $zero,$t1,4321
addu $t3,$t8,$t8
label1:
lui $t2,0
ori $v1,$s3,77
subu $s1,$t6,$s4
lui $s3,1
ori $s7,$s6,77
addu $a1,$v1,$t5
lui $s6,16
ori $t5,$v1,77
addu $t0,$s5,$t5
jr $ra
subu $t3,$t9,$s4
lui $v0,1
ori $t1,$s2,77
addu $v0,$t5,$s5
lui $s2,233
ori $s7,$t1,0
subu $s4,$s1,$s6
bgtz $s0,label2
lui $s4,134
ori $v1,$t8,4321
addu $t5,$t2,$s3
label2:
subu $t8,$s6,$s3
lui $s1,134
ori $s7,$t0,134
addu $a3,$t8,$a1
lui $t0,233
ori $t8,$t9,0
addu $a1,$s7,$t5
ori $t2,$t6,77
subu $a3,$v0,$t0
lui $t1,1
ori $s4,$t6,-233
addu $t2,$v0,$t5
lui $t0,233
ori $t6,$t3,1
addu $t0,$s4,$s7
ori $s0,$0,5542
ori $t0,$0,5542
beq $t0,$s0,label3
addu $t0,$t6,$zero
label3:
lui $s4,77
ori $s0,$zero,77
addu $t0,$a0,$t8
lui $zero,0
ori $s4,$s3,134
addu $t0,$t0,$s1
lui $a1,2
ori $s3,$t2,134
addu $s2,$t8,$v1
lui $t5,134
ori $t5,$t5,-16
addu $s5,$s0,$s5
jal label4
ori $s6,$t9,0
addu $a3,$a2,$s0
lui $t7,0
ori $s3,$v1,2
subu $s0,$v1,$zero
lui $a0,77
ori $a3,$s7,5542
addu $s5,$t5,$s4
label4:
lui $a2,0
ori $v1,$t2,77
addu $s5,$t3,$t1
jr $ra
addu $s5,$a2,$zero
jal label5
ori $s1,$t7,4321
subu $a1,$t1,$t5
lui $zero,134
ori $a3,$s6,5542
addu $zero,$t0,$t5
label5:
addu $t0,$s5,$v1
jr $ra
ori $t1,$a0,-16
subu $t8,$a3,$s1
lui $a2,134
ori $s0,$v1,0
addu $v1,$a2,$s5
lui $s0,134
ori $s4,$t8,5542
subu $s5,$a2,$a3
jal label6
subu $s3,$s1,$s5
lui $s6,5542
ori $t9,$s2,1
addu $v1,$s1,$t1
label6:
addu $s1,$t8,$a0
lui $a0,0
ori $v0,$s4,0
addu $a1,$t1,$t2
lui $a0,77
ori $t9,$a3,-16
subu $t5,$s1,$s2
lui $t7,233
ori $a3,$t7,2
addu $s1,$v0,$s3
jr $ra
subu $t9,$s5,$t6
ori $s0,$0,0
ori $t0,$0,0
beq $t0,$s0,label7
ori $t7,$s7,77
addu $v0,$s4,$v1
label7:
subu $t1,$t0,$a3
lui $s1,233
ori $t6,$v0,0
addu $t1,$t9,$t3
lui $a1,233
ori $t6,$s0,5542
subu $s4,$t0,$t5
lui $t2,77
ori $t5,$s0,4321
subu $v0,$t6,$v0
jal label8
lui $s7,0
ori $t0,$s5,134
addu $t7,$s6,$t2
lui $v1,2
ori $t3,$t7,2
addu $s1,$a2,$s0
label8:
addu $a2,$a3,$s6
lui $s4,16
ori $s1,$zero,-16
subu $s6,$a0,$s2
lui $a2,5542
ori $s5,$s2,134
addu $s2,$s0,$a2
lui $s5,1
ori $t7,$s2,-233
addu $t0,$a1,$a3
jr $ra
addu $a2,$s7,$s1
lui $s6,1
ori $t0,$t8,-16
addu $t6,$t0,$t3
bgtz $s0,label9
addu $a3,$t9,$t6
lui $t5,0
ori $t2,$t5,0
addu $v1,$s4,$t7
lui $v0,77
ori $t1,$v0,77
subu $t2,$a1,$a2
lui $a2,233
ori $v1,$s3,4321
subu $s7,$v0,$a2
label9:
subu $t0,$a2,$a1
lui $t1,134
ori $v0,$t3,0
addu $t0,$s1,$s5
lui $s6,16
ori $t5,$t5,1
addu $s4,$t8,$t9
