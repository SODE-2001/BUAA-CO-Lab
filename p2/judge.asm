.macro read(%n)
li $v0,5
syscall
la %n,($v0)
.end_macro
.macro getch(%n,%arr)
li $v0,12
syscall
sll $t0,%n,2
sw $v0,%arr($t0)
.end_macro
.macro print(%n)
li $v0,1
la $a0,(%n)
syscall
.end_macro
.macro putch(%n,%arr)
sll $t0,%n,2
lw $a0,%arr($t0)
li $v0,11
syscall
.end_macro

.data
str: .space 100

.text
read($k0)
li $s0,0
for1:
beq $s0,$k0,for1end
getch($s0,str)
addi $s0,$s0,1
j for1
for1end:

li $k1,1
li $s0,0
for2:
beq $s0,$k0,for2end
sll $t0,$s0,2
lw $s1,str($t0)
subi $t0,$k0,1
sub $t0,$t0,$s0
sll $t0,$t0,2
lw $s2,str($t0)
beq $s1,$s2,else1
li $k1,0
else1:
addi $s0,$s0,1
j for2
for2end:

print($k1)
li $v0,10
syscall