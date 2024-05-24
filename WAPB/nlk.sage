"""
Computing weightwise nonlinearity on the slices
"""

import time


## spherically punctured Reed Muller utilities

def Pkn(k,n, E):
  """Returns the linear code C over F2, that is a spherically punctured Reed Muller code of order 1 of lenght v=(n choose k)

  Args:
      k (Int)
      n (Int) 
      E = Ekn(n,k)

  Returns:
     AbstractLinearCode : spherically punctured Reed Muller code of order 1 of lenght v=(n choose k)
     #https://doc.sagemath.org/html/en/reference/coding/sage/coding/linear_code.html#linearcode
  """
  t = time.time()  
  b=binomial(n,k)
  M=ones_matrix(GF(2),n+1,b) 
  for i in range(b):
    M[1:,i]=int_bin_n(E[i],n) ##see supp_prop.sage
  C=LinearCode(M) #https://doc.sagemath.org/html/en/reference/coding/sage/coding/linear_code.html#linearcode
  return C
  
def h_distance(a,b):
   return (a+b).hamming_weight()

def dist_all(C, r):
  """
  Compute the distances between the vector r and all vectors in the code C.

  Args:
    C (AbstractLinearCode): [n, d]-linear code over GF(2) of length n and dimension d.
    r (vector): Vector of length n over GF(2).

  Returns:
    list: List of distances between the vector r and all vectors in the code C.
  """
  M = C.generator_matrix()
  d = C.dimension()
  it = prodit(range(2), repeat=d)
  t = time.time()
  distances = [((vector(GF(2), x) * M) + r).hamming_weight() for x in it] # main computation
#  print(f"Time taken for computing distances: {time.time() - t} seconds")
  return distances
 
def restriction(f,S):
  """Returns the restriction to S of the Boolean function f 

  Args:
      f (BooleanFunction) : a Boolean function in n variables
      S (list[int]): a subset of range(0,2^n)

  Returns:
      _type_: _description_
  """
  fT=f.truth_table('int')
  return vector(GF(2),[fT[i] for i in S])


def fun_par(M,r,x):
  """return the Hamming istance between the binary vectors x*M and t"""
  return h_dist(vector(GF(2),x)*M,r)   #main.sage   

        
def dist_all_parallel(C,r):
  """ Return the list of values of the distance between the vector r and any vector of the code C.
      This is the same as dist_all but  the computation is done in parrallel. 
  """  
  pool = Pool(cpu) 
  M1=C.generator_matrix()
  d=C.dimension()
  it=prodit(range(2), repeat=d)
  fun=partial(fun_par,M1,r)
  D=pool.imap(fun,it)#,   map(lambda x: vector(GF(2),x)*M ,it) 
  pool.close()
  pool.join()
  return list(D)


## NLks

def NLk(k,f):
    """Returns the weightwise nonlinearity of n-variable f on the slice Ekn, 
      via computing the distance between the spherically punctured Reed Muller code of order 1 of lenght v=(n choose k)  and the support of the restriction of f over the slide Ekn  as suggested in  https://ia.cr/2022/408
    
    Args:
        k (int): slice
        f (BooleanFunction):  n-variable f Boolean function

    Returns:
        int: weightwise nonlinearity of n-variable f on the slice Ekn
    """    
    n=f.nvariables()
    if k<0 or k>n: return 0
    t = time.time()
    E = Ekn(k,n)
#    print(f"Time for Ekn: {time.time()-t}")
    t = time.time()
    vf=restriction(f,E)
    return min(dist_all(Pkn(k,n, E),vf))
  
def NLk_par(k,f):
    """This is the same as NLk but runs in parallel"""
    n=f.nvariables()
    if k<0 or k>n: return 0

    E = Ekn(k,n)
    vf=restriction(f,E)
    return min(dist_all_parallel(Pkn(k,n, E),vf))  


def NLk_w(k,f):
    """Returns the weightwise nonlinearity of n-variable f on the slice Ekn, 
      via computing the Walsh tranform.

    Args:
        k (int): slice
        f (BooleanFunction):  n-variable f Boolan function

    Returns:
        int: weightwise nonlinearity of n-variable f on the slice Ekn
    """      
    n=f.nvariables()
    b=binomial(n,k)
    w=max([abs(walsh(f,a,Ekn(k,n))) for a in range(2^n)])
    return b/2-w/2
