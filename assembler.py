opcode_dict = dict(ADD=format(0,'04b'), ADC=format(0,'04b'), ADZ=format(0,'04b'),ADI=format(1,'04b'),NDU=format(2,'04b'),NDC=format(2,'04b'),NDZ=format(2,'04b'),LHI=format(3,'04b'),LW=format(4,'04b'),SW=format(5,'04b'),LM=format(6,'04b'),SM=format(7,'04b'),JAL=format(8,'04b'),JLR=format(9,'04b'),BEQ=format(12,'04b'))
reg_dict = dict(R0=format(0,'03b'),R1=format(1,'03b'),R2=format(2,'03b'),R3=format(3,'03b'),R4=format(4,'03b'),R5=format(5,'03b'),R6=format(6,'03b'),R7=format(7,'03b'))
opcode = (*opcode_dict,)

f = open("Factorial.txt", "r")
g = open("bin_program.txt", "w")
for z in f:    
 asm_inst = z;
 x = asm_inst.split(",")
 y = x[0].split()
 x[1] = x[1].rstrip()
 #number = len(x);
 if len(x) == 3:
  x[2] = x[2].rstrip()
 #print(asm_inst) 
 #print(y[0])     # y[0] has opcode
 #print(y[1])     # y[1] has Reg1
 #print(x[1])     # x[1] has Reg2 or IMME 9
 #print(x[2])     # x[2] has Reg3 or IMME 6

 if y[0] == opcode[0]:      #ADD
  bin_inst = opcode_dict[y[0]] + reg_dict[x[1]] + reg_dict[x[2]] + reg_dict[y[1]] + "000"

 elif y[0] == opcode[1]:    #ADC
  bin_inst = opcode_dict[y[0]] + reg_dict[x[1]] + reg_dict[x[2]] + reg_dict[y[1]] + "010"

 elif y[0] == opcode[2]:    #ADZ
  bin_inst = opcode_dict[y[0]] + reg_dict[x[1]] + reg_dict[x[2]]+ reg_dict[y[1]] + "001"
  
 elif y[0] == opcode[3]:    #ADI
  bin_inst = opcode_dict[y[0]] + reg_dict[y[1]] + reg_dict[x[1]] + x[2]

 elif y[0] == opcode[4]:    #NDU
  bin_inst = opcode_dict[y[0]] + reg_dict[x[1]] + reg_dict[x[2]]+ reg_dict[y[1]] + "000"

 elif y[0] == opcode[5]:    #NDC
  bin_inst = opcode_dict[y[0]] + reg_dict[x[1]] + reg_dict[x[2]]+ reg_dict[y[1]] + "010"

 elif y[0] == opcode[6]:    #NDZ
  bin_inst = opcode_dict[y[0]] + reg_dict[x[1]] + reg_dict[x[2]]+ reg_dict[y[1]] + "001" 

 elif y[0] == opcode[7]:    #LHI  
  bin_inst = opcode_dict[y[0]] + reg_dict[y[1]] + x[1]

 elif y[0] == opcode[8]:    #LW
  bin_inst = opcode_dict[y[0]] + reg_dict[y[1]] + reg_dict[x[1]] + x[2]

 elif y[0] == opcode[9]:    #SW
  bin_inst = opcode_dict[y[0]] + reg_dict[y[1]] + reg_dict[x[1]] + x[2]

 elif y[0] == opcode[10]:   #LM
  bin_inst = opcode_dict[y[0]] + reg_dict[y[1]] + "0" + x[1]
  
 elif y[0] == opcode[11]:   #SM  
  bin_inst = opcode_dict[y[0]] + reg_dict[y[1]] + "0" + x[1]

 elif y[0] == opcode[12]:   #JAL  
  bin_inst = opcode_dict[y[0]] + reg_dict[y[1]] + x[1]

 elif y[0] == opcode[13]:   #JLR
  bin_inst = opcode_dict[y[0]] + reg_dict[y[1]] + reg_dict[x[1]] + "000000"
  
 elif y[0] == opcode[14]:   #BEQ 
  bin_inst = opcode_dict[y[0]] + reg_dict[y[1]] + reg_dict[x[1]] + x[2]
  
 print(bin_inst)
 g.write(bin_inst + "\n")
f.close()
g.close()





