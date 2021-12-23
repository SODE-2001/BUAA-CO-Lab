ori $s0,$0,100
sw $s0,4092($0)
ori $s1,$0,4092
lw $s1,0($s1)
sw $s0,-100($s0)
lw $s2,0($0)

jal begin
subu $v1,$s4,$s3
j end
begin:
addu $s3,$s0,$s1
ori $s4,$s1,5432
jr $ra
end: