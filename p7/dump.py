import os

def ise():
    xilinx_path='D:\\Xilinx\\14.7\\ISE_DS\\ISE'
    os.environ['XILINX'] = xilinx_path
    os.system(xilinx_path + '\\bin\\nt64\\fuse -nodebug -prj mips.prj -o mips.exe mips_txt>log.txt')
    os.system('mips.exe -nolog -tclbatch mips.tcl> test_ans.txt')

def get_code(idx):
    file_name="mine_correct/testpoint"+str(idx)+".asm"
    os.system(r"java -jar mars2.jar a db mc CompactDataAtZero dump 0x00003000-0x00004ffc HexText text.txt "+file_name)
    ## dump ktext
    os.system(r"java -jar mars2.jar a db mc CompactDataAtZero dump 0x00004180-0x00004ffc HexText ktext.txt "+file_name)
    with open(r"text.txt","r") as textfile:
        with open(r"ktext.txt","r") as ktextfile:
            with open("./mips/code.txt","w") as codefile1:
                for i in range(0x3000,0x4180,4) :
                    ret1 =textfile.readline()
                    if(ret1):
                        codefile1.write(ret1)
                    else:
                        codefile1.write("00000000\n")
                codefile1.write(ktextfile.read())

    with open(r"text.txt","r") as textfile:
        with open(r"ktext.txt","r") as ktextfile:
            with open("./wxg/code.txt","w") as codefile2:
                for i in range(0x3000,0x4180,4) :
                    ret1 =textfile.readline()
                    if(ret1):
                        codefile2.write(ret1)
                    else:
                        codefile2.write("00000000\n")
                codefile2.write(ktextfile.read())
    
    os.chdir("./mips")
    print(os.getcwd())
    ise()
    os.chdir("../wxg")
    print(os.getcwd())
    ise()
    os.chdir("..")
    print(os.getcwd())

    with open("./mips/test_ans.txt","r") as f1:
        with open("./wxg/test_ans.txt","r") as f2:
            txt1=f1.readlines()
            txt2=f2.readlines()
            if(txt1==txt2): print("\n"+str(idx)+" : accept\n")
            else: raise("wrong "+file_name)


for i in range(11,14):
    get_code(i)