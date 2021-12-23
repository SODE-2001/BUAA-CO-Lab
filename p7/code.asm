.ktext 0x4180
mfc0	 $k0, $12 			#get SR
mfc0 $k0, $13 			#get Cause
mfc0 $k0, $14 			#get EPC

mfc0 $k0, $13
ori  $k1, $0, 0x007c
and	 $k0, $k1, $k0 		#get ExcCode
beq  $0, $k0, ERET 		#is Interrupt
mfc0 $k0, $14 			#get EPC

andi  $k1, $k1, 0xfffc	#EPC align
addiu $k0, $k0, 4 		
mtc0 $k0, $14 			# EPC = EPC+4
j	 ERET				
nop

ERET:
eret
nop