import os
import cmp

def ise():
    xilinx_path='D:\\Xilinx\\14.7\\ISE_DS\\ISE'
    os.environ['XILINX'] = xilinx_path
    os.system(xilinx_path + '\\bin\\nt64\\fuse -nodebug -prj mips.prj -o mips.exe test>log.txt')
    os.system('mips.exe -nolog -tclbatch mips.tcl> test_ans.txt')

def mars():
    hexCodeDir="code.txt"
    spMarsJarDir = "mars2.jar"
    stdLogDir="ans.txt"
    os.system("java -jar "+spMarsJarDir+" test.asm"+" nc mc CompactDataAtZero a dump .text HexText "+hexCodeDir) 
    os.system("java -jar "+spMarsJarDir+" test.asm"+" nc mc CompactDataAtZero >"+stdLogDir) 

mars()
ise()
cmp.check()