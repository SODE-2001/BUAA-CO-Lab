import random
import test
import cmp

block3=['addu','subu']
block2=['ori']
block1=['lui']
memory=['sw','lw','sh','lh','sb','lb']
branch=['beq','bgtz']
jump=['j','jal','jr']
register=['$zero','$v0','$v1','$a0','$a1','$a2','$a3','$t0','$t1','$t2','$t3','$t5','$t6','$t7','$s0','$s1',
'$s2','$s3','$s4','$s5','$s6','$s7','$t8','$t9']
imm=['0','1','2','5542','134','77','4321','-16','-233']

def block(num=0):
    with open('test.asm','a') as f:
        if num==0:
            num=random.randrange(1,11)
        while num:
            num=num-1
            if num%3==0:
                instr=block3[random.randrange(0,len(block3))]
                rs=register[random.randrange(0,len(register))]
                rt=register[random.randrange(0,len(register))]
                rd=register[random.randrange(0,len(register))]
                f.write(instr+' '+rs+','+rt+','+rd+'\n')
            elif num%3==1:
                instr=block2[random.randrange(0,len(block2))]
                rs=register[random.randrange(0,len(register))]
                rt=register[random.randrange(0,len(register))]
                imm16=imm[random.randrange(0,len(imm))]
                f.write(instr+' '+rs+','+rt+','+imm16+'\n')
            else:
                instr=block1[random.randrange(0,len(block1))]
                rs=register[random.randrange(0,len(register))]
                imm16=imm[random.randrange(0,len(imm))]
                f.write(instr+' '+rs+','+str(abs(eval(imm16)))+'\n')

def jal(label):
    with open('test.asm','a') as f:
        f.write('jal '+label+'\n')
    block()
    with open('test.asm','a') as f: 
        f.write('j jalend'+label[-1]+'\n')
        f.write(label+':\n')
    block()
    with open('test.asm','a') as f:
        f.write('jr $ra\n')
        f.write('jalend'+label[-1]+':\n')

def branch(label):
    with open('test.asm','a') as f:
        if random.randrange(0,2)==1:
            imm16=imm[random.randrange(0,len(imm))]
            f.write('ori $s0,$0,'+imm16+'\n')
            f.write('ori $t0,$0,'+imm16+'\n')
            f.write('beq $t0,$s0,'+label+'\n')
        else:
            f.write('bgtz $s0,'+label+'\n')
    block()
    with open('test.asm','a') as f: 
        f.write(label+':\n')
    block()

def initial():
    with open('test.asm','a') as f: 
        for reg in register:
            f.write('ori '+reg+',$0,1234\n')


if __name__ == '__main__':
    with open('test.asm','w') as f:
        f.write('')

    initial()
    labelNum=10
    for i in range(0,labelNum):
        block()
        if random.randrange(0,2)==1:
            branch('label'+str(i))
        else:
            jal('label'+str(i))
    test.mars()
    test.ise()
    cmp.check()