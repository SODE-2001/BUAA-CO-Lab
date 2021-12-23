.macro read(%n)
li $v0,5
syscall
la %n,($v0)
.end_macro
.macro print(%n)
la $a0,(%n)
li $v0,1
syscall 
.end_macro
.macro print_s(%n)
la $a0,%n
li $v0,4
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
A: .space 400
B: .space 400
C: .space 400
space: .asciiz " "
endl: .asciiz "\n"

.text
read($s0)	#n

li $s1,0 
for1:
beq $s1,$s0,for1end
li $s2,0 
for2:
beq $s2,$s0,for2end
read($t1)
index($s1,$s2,$s0,$t0)
sdata(A,$t0,$t1)
addi $s2,$s2,1
j for2
for2end:
addi $s1,$s1,1
j for1
for1end:

li $s1,0 
for3:
beq $s1,$s0,for3end
li $s2,0 
for4:
beq $s2,$s0,for4end
read($t1)
index($s1,$s2,$s0,$t0)
sdata(B,$t0,$t1)
addi $s2,$s2,1
j for4
for4end:
addi $s1,$s1,1
j for3
for3end:

li $s1,0 
for5:
beq $s1,$s0,for5end
li $s2,0 
for6:
beq $s2,$s0,for6end
li $s3,0
for7:
beq $s3,$s0,for7end
index($s1,$s3,$s0,$t0)
ldata(A,$t0,$t0)
index($s3,$s2,$s0,$t1)
ldata(B,$t1,$t1)
mul $t1,$t0,$t1	#a[i,k]*b[k,j]
index($s1,$s2,$s0,$t0)
ldata(C,$t0,$t0) 
add $t1,$t0,$t1 
index($s1,$s2,$s0,$t0)
sdata(C,$t0,$t1)		#c[i,j]+=a[i,k]*b[k,j]
addi $s3,$s3,1
j for7
for7end:  
addi $s2,$s2,1
j for6
for6end:
addi $s1,$s1,1
j for5
for5end:

li $s1,0 
for8:
beq $s1,$s0,for8end
li $s2,0 
for9:
beq $s2,$s0,for9end
index($s1,$s2,$s0,$t0)
ldata(C,$t0,$t1)
print($t1)
print_s(space)
addi $s2,$s2,1
j for9
for9end:
print_s(endl)
addi $s1,$s1,1
j for8
for8end: