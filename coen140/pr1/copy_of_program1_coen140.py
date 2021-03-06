# -*- coding: utf-8 -*-
"""Copy of program1_coen140.ipynb

Automatically generated by Colaboratory.

Original file is located at
    https://colab.research.google.com/drive/1blSVpMdsMLceJgNDVutXYdZGkNqVpFQ4
"""

import numpy as np
import pandas as pd
import scipy.sparse as sp
from numpy.linalg import norm
from collections import Counter, defaultdict
from scipy.sparse import csr_matrix

df_te = pd.read_csv(
    filepath_or_buffer='test.dat', delimiter='\t')
df_tr = pd.read_csv(
    filepath_or_buffer='train.dat', delimiter='\t')
df_format = pd.read_csv(
    filepath_or_buffer='format.dat')

vals = df_tr.iloc[:,:].values
vals1 = df_te.iloc[:,:].values
vals2 = df_format.iloc[:,:].values

y_train = vals[:,0]
x_train = vals[:,1]
names = x_train
cls = y_train

randomTestIDXs = vals2[:,0]
x_test = vals1[:,0]

print(y_train.shape)

def cmer(name, c=3):
    """ Given a name and parameter c, return the vector of c-mers associated with the name
    """
    name = name.lower()
    if len(name) < c:
        return [name]
    v = []
    for i in range(len(name)-c+1):
        v.append(name[i:(i+c)])
    return v

def build_matrix(docs, idx = {}):
    r""" Build sparse matrix from a list of documents, 
    each of which is a list of word/terms in the document.  
    """
    nrows = len(docs)
    tid = 0
    nnz = 0
    if idx:
      for d in docs:
        nnz += len([w for w in set(d) if w in idx])
    else:
      for d in docs:
          nnz += len(set(d))
          for w in d:
              if w not in idx:
                  idx[w] = tid
                  tid += 1
    ncols = len(idx)
        
    # set up memory
    ind = np.zeros(nnz, dtype=np.int)
    val = np.zeros(nnz, dtype=np.double)
    ptr = np.zeros(nrows+1, dtype=np.int)
    i = 0  # document ID / row counter
    n = 0  # non-zero counter
    # transfer values
    for d in docs:
        cnt = Counter(d)
        keys = list(k for k,_ in cnt.most_common() if k in idx)
        l = len(keys)
        for j,k in enumerate(keys):
            ind[j+n] = idx[k]
            val[j+n] = cnt[k]
        ptr[i+1] = ptr[i] + l
        n += l
        i += 1
            
    mat = csr_matrix((val, ind, ptr), shape=(nrows, ncols), dtype=np.double)
    mat.sort_indices()
    
    return mat, idx

def csr_l2normalize(mat, copy=False, **kargs):
    r""" Normalize the rows of a CSR matrix by their L-2 norm. 
    If copy is True, returns a copy of the normalized matrix.
    """
    if copy is True:
        mat = mat.copy()
    nrows = mat.shape[0]
    nnz = mat.nnz
    ind, val, ptr = mat.indices, mat.data, mat.indptr
    # normalize
    for i in range(nrows):
        rsum = 0.0    
        for j in range(ptr[i], ptr[i+1]):
            rsum += val[j]**2
        if rsum == 0.0:
            continue  # do not normalize empty rows
        rsum = 1.0/np.sqrt(rsum)
        for j in range(ptr[i], ptr[i+1]):
            val[j] *= rsum
            
    if copy is True:
        return mat
        
def namesToMatrix(names, c):
    docs = [cmer(n, c) for n in names]
    return build_matrix(docs)

def classify(x, train, clstr):
        r""" Classify vector x using kNN and majority vote rule given training data and associated classes
        """
        # find nearest neighbors for x
        dots = x.dot(train.T)
        sims = list(zip(dots.indices, dots.data))
        if len(sims) == 0:
            # could not find any neighbors
            return '+' if np.random.rand() > 0.5 else '-'
        sims.sort(key=lambda x: x[1], reverse=True)
        tc = Counter(clstr[s[0]] for s in sims[:k]).most_common(2)
        if len(tc) < 2 or tc[0][1] > tc[1][1]:
            # majority vote
            return tc[0][0]
        # tie break
        tc = defaultdict(float)
        for s in sims[:k]:
            tc[clstr[s[0]]] += s[1]
        return sorted(tc.items(), key=lambda x: x[1], reverse=True)[0][0]

k=5
c=2
doc_train = [cmer(n, c) for n in x_train]
doc_test = [cmer(n, c) for n in x_test]


mat_train, idx = build_matrix(doc_train)
mat_test, _ = build_matrix(doc_test, idx)
csr_l2normalize(mat_train)
csr_l2normalize(mat_test)

prediction_train = [ classify(mat_train[i,:], mat_train, y_train) for i in range(mat_train.shape[0]) ]

prediction_test = [ classify(mat_test[i,:], mat_train, y_train) for i in range(mat_test.shape[0]) ]

print(prediction_test)

acc = 0.0
for i in range(len(y_train)):
    if y_train[i] == prediction_train[i]:
        acc += 1
acc /= len(y_train)
print(acc)

best = (0.0, 0.0, 0.0)
for c in range(1,5):
    for k in range(1, 7):
        macc = classifyNames(names, cls, c=c, k=k)
        print("c=%d, k=%d, %f" % (c, k, macc))
        if macc > best[2]:
            best = (c, k, macc)
print("Best: c=%d, k=%d, %f" % best)