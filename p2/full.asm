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
.data
space: .asciiz " "
endl: .asciiz "\n"
arr: .space 100
vis: .space 100

.text
read($s0)	#n
li $a1,0
jal dfs
li $v0,10 
syscall

dfs:		#$a1 is k
bne $a1,$s0,else1	#if start
li $s1,0		#i
for1:
beq $s1,$s0,for1end
ldata(arr,$s1,$t0)
print($t0)
print_s(space)
addi $s1,$s1,1
j for1
for1end:
print_s(endl)		
j else1end	#if end
else1:
li $s1,0
for2:
beq $s1,$s0,for2end
ldata(vis,$s1,$t0)
bgtz $t0,else2
li $t0,1
sdata(vis,$s1,$t0)
add $t0,$t0,$s1		#i+1
sdata(arr,$a1,$t0)
addi $sp,$sp,-12
sw $a1,0($sp)
sw $ra,4($sp)
sw $s1,8($sp)
addi $a1,$a1,1	
jal dfs
lw $a1,0($sp)
lw $ra,4($sp)
lw $s1,8($sp)
addi $sp,$sp,12
li $t0,0
sdata(vis,$s1,$t0)
else2:
addi $s1,$s1,1
j for2
for2end:
else1end:
jr $ra