````assembly
ori $s0,$0,123
ori $s1,$0,-5
addu $s2,$s1,$s0
addu $s0,$s0,$s2
subu $s3,$s1,$s0
lui $s2,333
subu $s3,$s2,$s1
````

````assembly
ori $s0,$0,123
ori $s1,$0,233
subu $s2,$s0,$s1
ori $t0,$0,119
sw $s2,5($t0)
addu $s2,$s1,$s0
ori $t1,$0,5
addu $t1,$t0,$t1
lw $t0,0($t1)
subu $t1,$t0,$t1
````

````assembly
lui $s0,77
beq $s0,$s1,xxx
addu $s1,$0,$s0
xxx:
ori $t0,$0,432
beq $s0,$s1,xx
ori $t0,$0,111
ori $t3,$s1,22
xx:
jal begin
ori $t0,$t1,221
addu $s0,$s1,$t0
subu $s0,$s1,$t0
j end
subu $t0,$t1,$t2
begin:
sw $t3,16($0)
lw $s3,16($0)
addu $s2,$s3,$s0
jr $ra
nop
end:
````

````assembly
ori $s0,$0,0x3014
addu $t0,$0,$0
sw $s0,4($t0)
jal begin
lw $ra,4($t0)
j end
addu $ra,$ra,$s0
begin:
addu $s0,$t0,$t0
jr $ra
nop
end:
````

````assembly
ori $t1,$0,321
subu $t0,$0,$t1
bgezal $t0,begin
addu $s0,$0,$0
bgezal $t1,begin
addu $s0,$t0,$0
j end
addu $s0,$t0,$0
begin:
subu $t1,$t0,$t1
addu $t2,$t1,$t0
jr $ra
nop 
end:
````



