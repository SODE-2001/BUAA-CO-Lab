| 指令 | TuseRs(D) | TuseRt(D) | Tnew(E) |
| :--: | :-------: | :-------: | :-----: |
| addu |     1     |     1     |    1    |
| subu |     1     |     1     |    1    |
| ori  |     1     |     x     |    1    |
|  lw  |     1     |     x     |    2    |
|  sw  |     1     |     2     |    x    |
|  j   |     x     |     x     |    x    |
| jal  |     x     |     x     |    0    |
|  jr  |     0     |     x     |    x    |
| beq  |     0     |     0     |    x    |
| lui  |     x     |     x     |    0    |

Tuse : x=3

Tnew : x=0