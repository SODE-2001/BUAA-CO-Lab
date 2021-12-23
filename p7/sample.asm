lui $t1,128			#ov
lui $t2,129
add $t1,$t1,$t2

sw $t1,0($t2)		#AdEL AdES
ori $t2,$0,16
lw $t1,-20($t2)

ori $t1,$0,2			#AdEL
jal begin
addu $ra,$ra,$t1
begin:
jr $ra
nop

lh $t2,1($t1)		#AdEL
lw $t2,3($t1)
jal begin2
addi $ra,$ra,16384
begin2:
jr $ra
sub $ra,$ra,$t1

