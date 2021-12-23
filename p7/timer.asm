ori $t1,$0,100
ori $t2,$0,32516
sw $t1,0($t2)

ori $t1,$0,9
addi $t2,$t2,-4
sw $t1,0($t2)

loop:
bnez $t1,next
nop
next:
j loop
nop

.ktext 0x4180
mfc0	 $k0, $12 			#get SR
mfc0 $k0, $13 			#get Cause
mfc0 $k0, $14 			#get EPC

mfc0 $k0, $13
ori  $k1, $0, 0x007c
and	 $k0, $k1, $k0 		#get ExcCode

ori $t1,$0,9
ori $t2,$0,32512
sw $t1,0($t2)

eret
nop

