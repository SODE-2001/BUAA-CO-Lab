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
arr: .space 400
space: .asciiz " "
endl: .asciiz "\n"

.text
read($k0)
read($k1)
mul $t0,$k0,$k1
li $s0,0
for1:
beq $s0,$t0,for1end
read($t1)
sdata(arr,$s0,$t1)
addi $s0,$s0,1
j for1
for1end:

read($s1) #x1
addi $s1,$s1,-1
read($s2) #y1
addi $s2,$s2,-1
read($s3) #x2
addi $s3,$s3,-1
read($s4) #y2
addi $s4,$s4,-1
index($s1,$s2,$k1,$t0)
li $t1,1
sdata(arr,$t0,$t1)
li $s5,0	  #ans

###
#li $s0,0
#for2:
#bge $s0,$k0,for2end
#li $s1,0
#for3:
#bge $s1,$k1,for3end
#index($s0,$s1,$k1,$t0)
#ldata(arr,$t0,$t0)
#print($t0)
#print_s(space)
#addi $s1,$s1,1
#j for3
#for3end:
#print_s(endl)
#addi $s0,$s0,1
#j for2
#for2end:
###
   
la $a1,($s1)
la $a2,($s2)
jal dfs
print($s5)
li $v0,10
syscall 

dfs:
bne $a1,$s3,if0end
bne $a2,$s4,if0end
if0:
addi $s5,$s5,1
j else0end
if0end:
else0:

ble $a1,0,if1end
la $t0,($a1)
addi $t0,$t0,-1
index($t0,$a2,$k1,$t0)
ldata(arr,$t0,$t1) #t0 is index, t1 is arr[,]
bgtz $t1,if1end
if1:
li $t1,1
sdata(arr,$t0,$t1)
addi $sp,$sp,-8
sw $ra,0($sp)
sw $t0,4($sp)
addi $a1,$a1,-1
jal dfs
addi $a1,$a1,1
lw $ra,0($sp) 
lw $t0,4($sp)
addi $sp,$sp,8
li $t1,0
sdata(arr,$t0,$t1)
if1end:

ble $a2,0,if2end
la $t0,($a2)
addi $t0,$t0,-1
index($a1,$t0,$k1,$t0)
ldata(arr,$t0,$t1) #t0 is index, t1 is arr[,]
bgtz $t1,if2end
if2:
li $t1,1
sdata(arr,$t0,$t1)
addi $sp,$sp,-8
sw $ra,0($sp)
sw $t0,4($sp)
addi $a2,$a2,-1
jal dfs
addi $a2,$a2,1
lw $ra,0($sp) 
lw $t0,4($sp)
addi $sp,$sp,8
li $t1,0
sdata(arr,$t0,$t1)
if2end:

addi $t1,$k0,-1
bge $a1,$t1,if3end
la $t0,($a1)
addi $t0,$t0,1
index($t0,$a2,$k1,$t0)
ldata(arr,$t0,$t1) #t0 is index, t1 is arr[,]
bgtz $t1,if3end
if3:
li $t1,1
sdata(arr,$t0,$t1)
addi $sp,$sp,-8
sw $ra,0($sp)
sw $t0,4($sp)
addi $a1,$a1,1
jal dfs
addi $a1,$a1,-1
lw $ra,0($sp) 
lw $t0,4($sp)
addi $sp,$sp,8
li $t1,0
sdata(arr,$t0,$t1)
if3end:

addi $t1,$k1,-1
bge $a2,$t1,if4end
la $t0,($a2)
addi $t0,$t0,1
index($a1,$t0,$k1,$t0)
ldata(arr,$t0,$t1) #t0 is index, t1 is arr[,]
bgtz $t1,if4end
if4:
li $t1,1
sdata(arr,$t0,$t1)
addi $sp,$sp,-8
sw $ra,0($sp)
sw $t0,4($sp)
addi $a2,$a2,1
jal dfs
addi $a2,$a2,-1
lw $ra,0($sp) 
lw $t0,4($sp)
addi $sp,$sp,8
li $t1,0
sdata(arr,$t0,$t1)
if4end:

else0end:
jr $ra