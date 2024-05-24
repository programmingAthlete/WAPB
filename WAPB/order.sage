
#Construction1:
#In input, a list of of vectors of size 2, 2^2, ..., 2^(m-1) corresponding to the orders, in output the truth table of f
#We decided to encode the binary strings as integers
def Construction1(m,listOrders):
    TT=[]
    for elem in range(2^(2^m)):
        #print(elem)
        if elem==0:
            TT.append(GF(2)(0))
        else:
            if elem==(2^(2^m)-1):
                TT.append(GF(2)(1))
            else:
                #divide:
                #track the recursion order
                rec=0
                left= mod(elem,2^(2^(m-1)))
                right= (elem - ZZ(mod(elem,2^(2^(m-1)))))/ 2^(2^(m-1))
                right=mod(right,2^(2^(m-1)))
          #      print(rec,left,right,left==right)
                while(left==right):
                    rec+=1
                    elem=left
                    left= mod(elem,2^(2^(m-1-rec)))
                    right= ZZ(elem - ZZ(left))
                    if (right!=0):
                        right=right/ 2^(2^(m-1-rec))
                    right=mod(right,2^(2^(m-1-rec)))
                #print(rec,left,right)
                #Here left and right are different and they are elements of size 2^(2^(m-1-rec))
                if listOrders[m-rec-1].index(left) < listOrders[m-rec-1].index(right):
                        TT.append(GF(2)(0))
                else:
                        TT.append(GF(2)(1))
        #print(TT)

    return(TT)
    
#In the following some example of orders we tested

    
#Lexicographic order 
#example m=4
listLex=[[0,1],[0,1,2,3],[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15],[i for i in range(2^8)]]

#TT=Construction1(4,listLex)                                                                                                                                                                          
#f=BooleanFunction(TT)    
#for i in range(13):                                                                                                                                                                            
#	print(i+2,NLk(i+2,f))

#TT=Construction1(3,listLex)                                                                                                                                                                          
#f=BooleanFunction(TT)    
#for i in range(2,7):                                                                                                                                                                            
#	print(i,NLk(i,f))





    
    
#cool order
def CoolSuccessor(size,init):
    current=init
    #successive rule
    found=0
    cpt=1
    while(not found):
        #print(current,cpt,found)
        if cpt==size-1:
            found=1
            tmp=1-current[0]
            current.pop(0)
            current.append(tmp)
         #   print(current)
         #   print(found)
        else:
            if current[cpt]==1 and current[cpt+1]==0:
                #rotate cpt+1 first bitsbits
                tmp=[]
                for i in range(cpt+1):
                    tmp.append(current[i+1])
                tmp.append(current[0])
                for i in range(size-cpt-2):
                #    print(i+cpt+2)
                    tmp.append(current[i+cpt+2])
                current=tmp
             #   print(current)
                found=1
            else:
                cpt+=1
    return(current)

def reverseBinary(v):
    w=v.copy()
    w.reverse()
    cpt=0
    for i in range(len(v)):
        cpt+=w[i] * 2^i
    return(cpt)
    
    
#Example to create list of elements in the Cool order, starting at 0
   
#size=8
#v=[0,0,0,0 ,0,0,0,0]
#listCool8=[0]
#for i in range(2^size-1):
#    v=CoolSuccessor(size,v)
#    #print(v,reverseBinary(v))
#    listCool8.append(reverseBinary(v))




 
#example m=4
listCool=[[0,1],[0,1,3,2],[0,1,3,7,15,14,13,11,6,12,10,5,9,2,4,8],[0, 1, 3, 7, 15, 31, 63, 127, 255, 254, 253, 251, 247, 239, 223, 191, 126, 252, 250, 246, 238, 222, 190, 125, 249, 245, 237, 221, 189, 123, 243, 235, 219, 187, 119, 231, 215, 183, 111, 207, 175, 95, 159, 62, 124, 248, 244, 236, 220, 188, 122, 242, 234, 218, 186, 118, 230, 214, 182, 110, 206, 174, 94, 158, 61, 121, 241, 233, 217, 185, 117, 229, 213, 181, 109, 205, 173, 93, 157, 59, 115, 227, 211, 179, 107, 203, 171, 91, 155, 55, 103, 199, 167, 87, 151, 47, 79, 143, 30, 60, 120, 240, 232, 216, 184, 116, 228, 212, 180, 108, 204, 172, 92, 156, 58, 114, 226, 210, 178, 106, 202, 170, 90, 154, 54, 102, 198, 166, 86, 150, 46, 78, 142, 29, 57, 113, 225, 209, 177, 105, 201, 169, 89, 153, 53, 101, 197, 165, 85, 149, 45, 77, 141, 27, 51, 99, 195, 163, 83, 147, 43, 75, 139, 23, 39, 71, 135, 14, 28, 56, 112, 224, 208, 176, 104, 200, 168, 88, 152, 52, 100, 196, 164, 84, 148, 44, 76, 140, 26, 50, 98, 194, 162, 82, 146, 42, 74, 138, 22, 38, 70, 134, 13, 25, 49, 97, 193, 161, 81, 145, 41, 73, 137, 21, 37, 69, 133, 11, 19, 35, 67, 131, 6, 12, 24, 48, 96, 192, 160, 80, 144, 40, 72, 136, 20, 36, 68, 132, 10, 18, 34, 66, 130, 5, 9, 17, 33, 65, 129, 2, 4, 8, 16, 32, 64, 128]]

#TT=Construction1(4,listCool)                                                                                                                                                                          
#f=BooleanFunction(TT)    
#for i in range(13):                                                                                                                                                                            
#	print(i+2,NLk(i+2,f))





#Graded lex from low to high HW
#example m=4
listHWlex=[[0,1],[0,1,2,3],[0, 1,2,4,8, 3,5,6,9,10,12,  7,11, 13,14, 15],[0, 1, 2, 4, 8, 16, 32, 64, 128, 3, 5, 6, 9, 10, 12, 17, 18, 20, 24, 33, 34, 36, 40, 48, 65, 66, 68, 72, 80, 96, 129, 130, 132, 136, 144, 160, 192, 7, 11, 13, 14, 19, 21, 22, 25, 26, 28, 35, 37, 38, 41, 42, 44, 49, 50, 52, 56, 67, 69, 70, 73, 74, 76, 81, 82, 84, 88, 97, 98, 100, 104, 112, 131, 133, 134, 137, 138, 140, 145, 146, 148, 152, 161, 162, 164, 168, 176, 193, 194, 196, 200, 208, 224, 15, 23, 27, 29, 30, 39, 43, 45, 46, 51, 53, 54, 57, 58, 60, 71, 75, 77, 78, 83, 85, 86, 89, 90, 92, 99, 101, 102, 105, 106, 108, 113, 114, 116, 120, 135, 139, 141, 142, 147, 149, 150, 153, 154, 156, 163, 165, 166, 169, 170, 172, 177, 178, 180, 184, 195, 197, 198, 201, 202, 204, 209, 210, 212, 216, 225, 226, 228, 232, 240, 31, 47, 55, 59, 61, 62, 79, 87, 91, 93, 94, 103, 107, 109, 110, 115, 117, 118, 121, 122, 124, 143, 151, 155, 157, 158, 167, 171, 173, 174, 179, 181, 182, 185, 186, 188, 199, 203, 205, 206, 211, 213, 214, 217, 218, 220, 227, 229, 230, 233, 234, 236, 241, 242, 244, 248, 63, 95, 111, 119, 123, 125, 126, 159, 175, 183, 187, 189, 190, 207, 215, 219, 221, 222, 231, 235, 237, 238, 243, 245, 246, 249, 250, 252, 127, 191, 223, 239, 247, 251, 253, 254, 255]]


#Graded Cool from low to high HW
listHWcool=[[0, 1], [0, 1, 2, 3], [0, 1, 2, 4, 8, 3, 6, 12, 10, 5, 9, 7, 14, 13, 11, 15], [0, 1, 2, 4, 8, 16, 32, 64, 128, 3, 6, 12, 24, 48, 96, 192, 160, 80, 144, 40, 72, 136, 20, 36, 68, 132, 10, 18, 34, 66, 130, 5, 9, 17, 33, 65, 129, 7, 14, 28, 56, 112, 224, 208, 176, 104, 200, 168, 88, 152, 52, 100, 196, 164, 84, 148, 44, 76, 140, 26, 50, 98, 194, 162, 82, 146, 42, 74, 138, 22, 38, 70, 134, 13, 25, 49, 97, 193, 161, 81, 145, 41, 73, 137, 21, 37, 69, 133, 11, 19, 35, 67, 131, 15, 30, 60, 120, 240, 232, 216, 184, 116, 228, 212, 180, 108, 204, 172, 92, 156, 58, 114, 226, 210, 178, 106, 202, 170, 90, 154, 54, 102, 198, 166, 86, 150, 46, 78, 142, 29, 57, 113, 225, 209, 177, 105, 201, 169, 89, 153, 53, 101, 197, 165, 85, 149, 45, 77, 141, 27, 51, 99, 195, 163, 83, 147, 43, 75, 139, 23, 39, 71, 135, 31, 62, 124, 248, 244, 236, 220, 188, 122, 242, 234, 218, 186, 118, 230, 214, 182, 110, 206, 174, 94, 158, 61, 121, 241, 233, 217, 185, 117, 229, 213, 181, 109, 205, 173, 93, 157, 59, 115, 227, 211, 179, 107, 203, 171, 91, 155, 55, 103, 199, 167, 87, 151, 47, 79, 143, 63, 126, 252, 250, 246, 238, 222, 190, 125, 249, 245, 237, 221, 189, 123, 243, 235, 219, 187, 119, 231, 215, 183, 111, 207, 175, 95, 159, 127, 254, 253, 251, 247, 239, 223, 191, 255]]




#field order (for m=3), starting at 0, fields from sage, F4 with a^2+a+1, F16 with a^4+a+1. LSB on the right side at the end
#listField=[[0,1],[0, 1, 3, 2],[0, 4, 2, 1, 12, 6, 3, 13, 10, 5, 14, 7, 15, 11, 9, 8]]

#Code to fill the table with the parameters of functions in 8 variables with the field order.
def orderField3():

	for i in range(4):
		for j in range(16):
			TT=Construction1(3,listField)
			f=BooleanFunction(TT)
			print(i,j)
			print(listField)
			
			print(f.algebraic_degree())
			print("$ ",i,"$ & $ ",j,"$ & $",f.resiliency_order(),"$ & $",f.algebraic_degree(),"$ & $",f.nonlinearity(),"$ & $",f.algebraic_immunity(),"$ & $",NLk(2,f),"$ & $",NLk(3,f),
			"$ & $",NLk(4,f),"$ & $",NLk(5,f),"$ & $",NLk(6,f),"$ & $",AIk(2,f),"$ & $",AIk(3,f),"$ & $",AIk(4,f),"$ & $",AIk(5,f),"$ & $",AIk(6,f),"$ \\\ \hline")	
			
			listField[2].append(listField[2].pop(0))
		listField[1].append(listField[1].pop(0))
 
        #print(TT)

	return(0)



#field order (for m=4), starting at 0, fields from sage, F4 with a^2+a+1, F16 with a^4+a+1, F256 with a^8+a^4+a^3+a^2+1. LSB on the right side at the end


listFields0t0u0=[[0, 1], [0, 1, 3, 2], [0, 4, 2, 1, 12, 6, 3, 13, 10, 5, 14, 7, 15, 11, 9, 8], [0, 64, 32, 16, 8, 4, 2, 1, 184, 92, 46, 23, 179, 225, 200, 100, 50, 25, 180, 90, 45, 174, 87, 147, 241, 192, 96, 48, 24, 12, 6, 3, 185, 228, 114, 57, 164, 82, 41, 172, 86, 43, 173, 238, 119, 131, 249, 196, 98, 49, 160, 80, 40, 20, 10, 5, 186, 93, 150, 75, 157, 246, 123, 133, 250, 125, 134, 67, 153, 244, 122, 61, 166, 83, 145, 240, 120, 60, 30, 15, 191, 231, 203, 221, 214, 107, 141, 254, 127, 135, 251, 197, 218, 109, 142, 71, 155, 245, 194, 97, 136, 68, 34, 17, 176, 88, 44, 22, 11, 189, 230, 115, 129, 248, 124, 62, 31, 183, 227, 201, 220, 110, 55, 163, 233, 204, 102, 51, 161, 232, 116, 58, 29, 182, 91, 149, 242, 121, 132, 66, 33, 168, 84, 42, 21, 178, 89, 148, 74, 37, 170, 85, 146, 73, 156, 78, 39, 171, 237, 206, 103, 139, 253, 198, 99, 137, 252, 126, 63, 167, 235, 205, 222, 111, 143, 255, 199, 219, 213, 210, 105, 140, 70, 35, 169, 236, 118, 59, 165, 234, 117, 130, 65, 152, 76, 38, 19, 177, 224, 112, 56, 28, 14, 7, 187, 229, 202, 101, 138, 69, 154, 77, 158, 79, 159, 247, 195, 217, 212, 106, 53, 162, 81, 144, 72, 36, 18, 9, 188, 94, 47, 175, 239, 207, 223, 215, 211, 209, 208, 104, 52, 26, 13, 190, 95, 151, 243, 193, 216, 108, 54, 27, 181, 226, 113, 128]]


#creation of listFields128t0u0
listFields128t0u0=[]
for i in range(4):
	listFields128t0u0.append(listFields0t0u0[i].copy())
for i in range(128):
	listFields128t0u0[3].append(listFields128t0u0[3].pop(0))

#creation of listFields111t11u1
listFields111t11u1=[]
for i in range(4):
	listFields111t11u1.append(listFields0t0u0[i].copy())
for i in range(111):
	listFields111t11u1[3].append(listFields111t11u1[3].pop(0))
for i in range(11):
	listFields111t11u1[2].append(listFields111t11u1[2].pop(0))
for i in range(1):
	listFields111t11u1[1].append(listFields111t11u1[1].pop(0))

#creation of listFields31t3u1
#for i in range(31):
#	listFields0t0u0[3].append(listFields0t0u0[3].pop(0))
#for i in range(3):
#	listFields0t0u0[2].append(listFields0t0u0[2].pop(0))
#for i in range(1):
#	listFields0t0u0[1].append(listFields0t0u0[1].pop(0))


#TT=Construction1(4,listFields0t0u0)                                                                                                                                                                          
#f=BooleanFunction(TT)    
#for i in range(13):                                                                                                                                                                            
#	print(i+2,NLk(i+2,f))
	
#print(f.nonlinearity())
#print(f.algebraic_degree())

	
	
	
	
############################### WAPB	
	
	
	

#Construction for a WAPB function in n variables, given orders on binary strings od length floor(n/2), floor(n/4),... until 1 (in the everse order)
def Construction3(n,listOrders):
    nbOrders=floor(log(n,2))
    # floor(log(n)) orders
    #We build the truth table
    TT=[]
    #we work with integers
    for elem in range(2^n):
    #    print("")
    #    print(elem)

        nloc=n
        flag=0
        rec=0
        #We use a flag to g out of the while loop, for when we have left and right part different, or identical and of length 1
        while(flag==0):
            #in case nloc is odd
            if mod(nloc,2):
                #print("division by 2")
                nloc-=1
                elem=elem-ZZ(mod(elem,2))
                if elem !=0:
                    elem=elem/2
            #now we break elem in two parts of lentgth nloc/2
            #print("elem",elem)
            left=ZZ(mod(elem,2^(nloc/2)))
            #print(left)
            right=ZZ(elem-left)
            if right !=0:
                right=right/(2^(nloc/2))
            #print("elem",elem,"nloc",nloc)
            #print("left",left,"right", right)
            #Test the equality between both parts
            if left==right:
                #handle the case nloc=2 and 0,0 or 1,1
                if nloc==2:
                    # make an exception
                    flag=2
                else:
                    rec+=1
                    #print("in the equal loop, rec=",rec)
                    elem=left
                    nloc=nloc/2
            else:
                #case where left and right are different
                flag=1
     #   print("out of the loop")
     #   print(left,right, rec,flag)
        if flag==2:
            TT.append(GF(2)(left))
        else:
            if listOrders[nbOrders-rec-1].index(left) < listOrders[nbOrders-rec-1].index(right):
                 TT.append(GF(2)(0))
            else:
                 TT.append(GF(2)(1))
     #   print(TT)
    return(TT)


##### Some orders for the WAPB constructions in 10, 12 and 14 variables.

#lists for the lexicographic order
listLex10=[[0,1],[0,1,2,3],[i for i in range(2^5)]]
listLex12=[[0,1],[0,1,2,3,4,5,6,7],[i for i in range(2^6)]]
listLex14=[[0,1],[0,1,2,3,4,5,6,7],[i for i in range(2^7)]]

#lists for the Cool order
listCool10=[[0,1],[0, 1, 3, 2],[0, 1, 3, 7, 15, 31, 30, 29, 27, 23, 14, 28, 26, 22, 13, 25, 21, 11, 19, 6, 12, 24, 20, 10, 18, 5, 9, 17, 2, 4, 8, 16]]
listCool12=[[0,1],[0, 1, 3, 7, 6, 5, 2, 4],[0, 1, 3, 7, 15, 31, 63, 62, 61, 59, 55, 47, 30, 60, 58, 54, 46, 29, 57, 53, 45, 27, 51, 43, 23, 39, 14, 28, 56, 52, 44, 26, 50, 42, 22, 38, 13, 25, 49, 41, 21, 37, 11, 19, 35, 6, 12, 24, 48, 40, 20, 36, 10, 18, 34, 5, 9, 17, 33, 2, 4, 8, 16, 32]]
listCool14=[[0,1],[0, 1, 3, 7, 6, 5, 2, 4],[0, 1, 3, 7, 15, 31, 63, 127, 126, 125, 123, 119, 111, 95, 62, 124, 122, 118, 110, 94, 61, 121, 117, 109, 93, 59, 115, 107, 91, 55, 103, 87, 47, 79, 30, 60, 120, 116, 108, 92, 58, 114, 106, 90, 54, 102, 86, 46, 78, 29, 57, 113, 105, 89, 53, 101, 85, 45, 77, 27, 51, 99, 83, 43, 75, 23, 39, 71, 14, 28, 56, 112, 104, 88, 52, 100, 84, 44, 76, 26, 50, 98, 82, 42, 74, 22, 38, 70, 13, 25, 49, 97, 81, 41, 73, 21, 37, 69, 11, 19, 35, 67, 6, 12, 24, 48, 96, 80, 40, 72, 20, 36, 68, 10, 18, 34, 66, 5, 9, 17, 33, 65, 2, 4, 8, 16, 32, 64]]

#listHWlex
listHWLex10=[[0, 1], [0, 1, 2, 3], [0, 1, 2, 4, 8, 16, 3, 5, 6, 9, 10, 12, 17, 18, 20, 24, 7, 11, 13, 14, 19, 21, 22, 25, 26, 28, 15, 23, 27, 29, 30, 31]]
listHWLex12=[[0, 1], [0, 1, 2, 4, 3, 5, 6, 7], [0, 1, 2, 4, 8, 16, 32, 3, 5, 6, 9, 10, 12, 17, 18, 20, 24, 33, 34, 36, 40, 48, 7, 11, 13, 14, 19, 21, 22, 25, 26, 28, 35, 37, 38, 41, 42, 44, 49, 50, 52, 56, 15, 23, 27, 29, 30, 39, 43, 45, 46, 51, 53, 54, 57, 58, 60, 31, 47, 55, 59, 61, 62, 63] ]
listHWLex14=[[0, 1], [0, 1, 2, 4, 3, 5, 6, 7], [0, 1, 2, 4, 8, 16, 32, 64, 3, 5, 6, 9, 10, 12, 17, 18, 20, 24, 33, 34, 36, 40, 48, 65, 66, 68, 72, 80, 96, 7, 11, 13, 14, 19, 21, 22, 25, 26, 28, 35, 37, 38, 41, 42, 44, 49, 50, 52, 56, 67, 69, 70, 73, 74, 76, 81, 82, 84, 88, 97, 98, 100, 104, 112, 15, 23, 27, 29, 30, 39, 43, 45, 46, 51, 53, 54, 57, 58, 60, 71, 75, 77, 78, 83, 85, 86, 89, 90, 92, 99, 101, 102, 105, 106, 108, 113, 114, 116, 120, 31, 47, 55, 59, 61, 62, 79, 87, 91, 93, 94, 103, 107, 109, 110, 115, 117, 118, 121, 122, 124, 63, 95, 111, 119, 123, 125, 126, 127]  ]


#listHWcool
listHWcool10=[[0,1],[0, 1, 2, 3],[0, 1, 2, 4, 8, 16, 3, 6, 12, 24, 20, 10, 18, 5, 9, 17, 7, 14, 28, 26, 22, 13, 25, 21, 11, 19, 15, 30, 29, 27, 23, 31]]
listHWcool12=[[0,1],[0, 1, 2, 4, 3, 6, 5, 7],[0, 1, 2, 4, 8, 16, 32, 3, 6, 12, 24, 48, 40, 20, 36, 10, 18, 34, 5, 9, 17, 33, 7, 14, 28, 56, 52, 44, 26, 50, 42, 22, 38, 13, 25, 49, 41, 21, 37, 11, 19, 35, 15, 30, 60, 58, 54, 46, 29, 57, 53, 45, 27, 51, 43, 23, 39, 31, 62, 61, 59, 55, 47, 63]]
listHWcool14=[[0,1],[0, 1, 2, 4, 3, 6, 5, 7],[0, 1, 2, 4, 8, 16, 32, 64, 3, 6, 12, 24, 48, 96, 80, 40, 72, 20, 36, 68, 10, 18, 34, 66, 5, 9, 17, 33, 65, 7, 14, 28, 56, 112, 104, 88, 52, 100, 84, 44, 76, 26, 50, 98, 82, 42, 74, 22, 38, 70, 13, 25, 49, 97, 81, 41, 73, 21, 37, 69, 11, 19, 35, 67, 15, 30, 60, 120, 116, 108, 92, 58, 114, 106, 90, 54, 102, 86, 46, 78, 29, 57, 113, 105, 89, 53, 101, 85, 45, 77, 27, 51, 99, 83, 43, 75, 23, 39, 71, 31, 62, 124, 122, 118, 110, 94, 61, 121, 117, 109, 93, 59, 115, 107, 91, 55, 103, 87, 47, 79, 63, 126, 125, 123, 119, 111, 95, 127]]



#Fields ones
listField10s0t0u0=[[0,1],[0, 1, 3, 2],[0, 8, 4, 2, 1, 20, 10, 5, 22, 11, 17, 28, 14, 7, 23, 31,     27, 25, 24, 12, 6, 3, 21, 30, 15, 19, 29, 26, 13, 18, 9, 16]]
listField12s0t0u0=[[0,1],[0, 2, 1, 6, 3, 7, 5, 4],[0, 16, 8, 4, 2, 1, 54, 27, 59, 43, 35, 39, 37, 36, 18, 9, 50, 25, 58, 29, 56, 28, 14, 7, 53, 44, 22, 11, 51, 47, 33, 38,    19,  63, 41, 34, 17, 62, 31, 57, 42, 21, 60, 30, 15, 49, 46, 23, 61, 40, 20, 10, 5, 52, 26, 13, 48, 24, 12, 6, 3, 55, 45, 32]]
listField14s0t0u0=[[0,1],[0, 2, 1, 6, 3, 7, 5, 4],[0, 32, 16, 8, 4, 2, 1, 96, 48, 24, 12, 6, 3, 97, 80, 40, 20, 10, 5, 98, 49, 120, 60, 30, 15, 103, 83, 73, 68, 34, 17, 104, 52, 26, 13, 102, 51, 121, 92, 46, 23, 107, 85, 74, 37, 114, 57, 124, 62, 31, 111, 87, 75, 69, 66, 33, 112, 56, 28, 14, 7, 99, 81, 72, 36, 18, 9, 100, 50, 25, 108, 54, 27, 109, 86, 43, 117, 90, 45, 118, 59, 125, 94, 47, 119, 91, 77, 70, 35, 113, 88, 44, 22, 11, 101, 82, 41, 116, 58, 29, 110, 55, 123, 93, 78, 39, 115, 89, 76, 38, 19, 105, 84, 42, 21, 106, 53, 122, 61, 126, 63, 127, 95, 79, 71, 67, 65, 64]]


#Fields ones with the order on length-n/2 strings with s=n/2
listField10s16t0u0=[[0,1],[0, 1, 3, 2],[27, 25, 24, 12, 6, 3, 21, 30, 15, 19, 29, 26, 13, 18, 9, 16,   0, 8, 4, 2, 1, 20, 10, 5, 22, 11, 17, 28, 14, 7, 23, 31]]
listField12s32t0u0=[[0,1],[0, 2, 1, 6, 3, 7, 5, 4],[19,  63, 41, 34, 17, 62, 31, 57, 42, 21, 60, 30, 15, 49, 46, 23, 61, 40, 20, 10, 5, 52, 26, 13, 48, 24, 12, 6, 3, 55, 45, 32, 0, 16, 8, 4, 2, 1, 54, 27, 59, 43, 35, 39, 37, 36, 18, 9, 50, 25, 58, 29, 56, 28, 14, 7, 53, 44, 22, 11, 51, 47, 33, 38]]
listField14s64t0u0=[[0,1],[0, 2, 1, 6, 3, 7, 5, 4],[36, 18, 9, 100, 50, 25, 108, 54, 27, 109, 86, 43, 117, 90, 45, 118, 59, 125, 94, 47, 119, 91, 77, 70, 35, 113, 88, 44, 22, 11, 101, 82, 41, 116, 58, 29, 110, 55, 123, 93, 78, 39, 115, 89, 76, 38, 19, 105, 84, 42, 21, 106, 53, 122, 61, 126, 63, 127, 95, 79, 71, 67, 65, 64, 0, 32, 16, 8, 4, 2, 1, 96, 48, 24, 12, 6, 3, 97, 80, 40, 20, 10, 5, 98, 49, 120, 60, 30, 15, 103, 83, 73, 68, 34, 17, 104, 52, 26, 13, 102, 51, 121, 92, 46, 23, 107, 85, 74, 37, 114, 57, 124, 62, 31, 111, 87, 75, 69, 66, 33, 112, 56, 28, 14, 7, 99, 81, 72]]


listTest=[0,0,1,0,0,1,1,1,1,0,1,1,0,0,1,1,0,1,0,0,0,0,0,0,1,1,1,1,0,0,1,1,]



#Functions to print the parameters of a WAPB from Construction 3
def printParameters(n,listorders):
	TT=Construction3(n,listorders)
	f=BooleanFunction(TT)
	print(f.resiliency_order())
	print(f.nonlinearity())
	print("")
	for i in range(2,n-1):
		print(i,NLk(i,f))
	print("")
	print(f.algebraic_degree())
	print(my_algebraic_immunity(f))
	print("")
	for i in range(2,n-1):
		print(i,AIk(i,f))
	print("")
	return()
	





