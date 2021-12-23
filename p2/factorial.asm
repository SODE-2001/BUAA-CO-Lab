.macro read(%n)
li $v0,5
syscall
la %n,($v0)
.end_macro
.macro print(%n)
li $v0,1
la $a0,(%n) 
syscall
.end_macro
.macro print_s(%n)
li $v0,4
la $a0,%n
syscall 
.end_macro
.macro sdata(%arr,%index,%reg)
sll $t9,%index,2
sw %reg,%arr($t9)
.end_macro
.macro ldata(%arr,%index,%reg)
sll %reg,%index,2
lw %reg,%arr(%reg)
.end_macro
.macro index(%r,%c,%col,%reg)
mul $t9,%r,%col
add $t9,$t9,%c
la %reg,($t9)
.end_macro

.data
arr: .space 4040
space: .asciiz " "
endl: .asciiz "\n"

.text
read($k0)
li $t0,0
li $t1,1
sdata(arr,$t0,$t1)
li $s7,0 #end=0  

li $s1,2
for1:
bgt $s1,$k0,for1end
li $s0,0		#pre=0 
li $s2,0
for2:
bgt $s2,$s7,for2end
ldata(arr,$s2,$t0)
mul $t0,$t0,$s1
add $t0,$t0,$s0
li $t1,10
div $t0,$t1 
mfhi $t0
mflo $s0
sdata(arr,$s2,$t0)
bne $s2,$s7,if1end
ble $s0,0,if1end
if1:
addi $s7,$s7,1 
if1end:
addi $s2,$s2,1
j for2
for2end:
addi $s1,$s1,1
j for1
for1end:

la $s1,($s7)
for3:
blt $s1,0,for3end
ldata(arr,$s1,$t0)
print($t0)
addi $s1,$s1,-1
j for3
for3end:   

li $v0,10
syscall