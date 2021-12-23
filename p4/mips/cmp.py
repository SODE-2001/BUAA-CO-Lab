def check():
    with open('test_ans.txt','a') as f2:
        f2.write('\n')
    with open('ans.txt','r') as f1:
        with open('test_ans.txt','r') as f2:
            txt1=f1.readlines()
            txt2=f2.readlines()
            del txt2[0:5]
            if txt1==txt2:
                print('True')
            else:
                print('False')