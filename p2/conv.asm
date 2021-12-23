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
f: .space 400
h: .space 400
g: .space 400
space: .asciiz " "
endl: .asciiz "\n"

.text
read($s0)	#m1
read($s1)	#n1
read($s2)	#m2
read($s3)	#n2

mul $s4,$s0,$s1
li $s5,0
for1:
beq $s5,$s4,for1end
read($t0)
sdata(f,$s5,$t0)
addi $s5,$s5,1
j for1
for1end:

mul $s4,$s2,$s3
li $s5,0
for2:
beq $s5,$s4,for2end
read($t0)
sdata(h,$s5,$t0)
addi $s5,$s5,1
j for2
for2end:

#li $t0,2
#li $t1,1
#index($t0,$t1,$s1,$t0)
#ldata(f,$t0,$t1)
#print($t1)

sub $s4,$s0,$s2
sub $s5,$s1,$s3
addi $s4,$s4,1
addi $s5,$s5,1 
### compute
li $t1,0
for3:
beq $t1,$s4,for3end
li $t2,0
for4:
beq $t2,$s5,for4end
li $t7,0
### internal
li $t3,0
for5:
beq $t3,$s2,for5end
li $t4,0
for6:
beq $t4,$s3,for6end
add $t5,$t1,$t3
add $t6,$t2,$t4
index($t5,$t6,$s1,$t5)
ldata(f,$t5,$t5)		#f[i+k,j+l]
index($t3,$t4,$s3,$t6)
ldata(h,$t6,$t6)		#h[k,l]
mul $t5,$t5,$t6
add $t7,$t7,$t5
addi $t4,$t4,1
j for6
for6end:
addi $t3,$t3,1
j for5
for5end:
### internal
print($t7)
print_s(space)
addi $t2,$t2,1
j for4
for4end:
print_s(endl)
addi $t1,$t1,1
j for3
for3end:

li $v0,10
syscall