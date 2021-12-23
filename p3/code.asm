ori $s0,$0,123
jal dfs
ori $s1,$0,321
j end
dfs:
ori $s2,$0,-7
jr $ra
end: