# -*- coding: utf-8 -*-
"""COEN140_lab5_Jackson_Centeno.ipynb

Automatically generated by Colaboratory.

Original file is located at
    https://colab.research.google.com/drive/1Ux-ZTY_0hLbzVKlgOwwhxOXm29T7IfqE

#Logistic Regression Classification

spam classification using logistic regression. Do not use any
machine learning libraries; standard Python libraries and NumPy are allowed.
Consider the email spam data set. This consists of 4601 email messages, from which 57 features
have been extracted. These are as follows:


• 48 features, giving the percentage of words in a given message which match a given word on
the list. The list contains words such as “business”, “free”, “george”, etc. (The data was
collected by George Forman, so his name occurs quite a lot.)

• 6 features, giving the percentage of characters in the email that match a given character on the
list. The characters are ; ( [ ! $ #

• Feature 55: The average length of an uninterrupted sequence of capital letters

• Feature 56: The length of the longest uninterrupted sequence of capital

• Feature 57: The sum of the lengths of uninterrupted sequence of capital
1. Download the data at http://www.cse.scu.edu/~yfang/coen140/spambase.zip. The data is split
into a training set (of size 3065) and a test set (of size 1536).
a. After extraction, do not alter the name or contents of the files.
2. Normalize the features by standardizing the columns so they all have mean 0 and unit variance.
3. Build and fit a logistic regression model using gradient descent.
a. Report the error rate on the training and test sets. Error rate is percentage of wrong answers

# Import Data

The data consists of local crime statistics for 1,994 US communities. The response 𝑦 is the crime
rate. The name of the response variable is ViolentCrimesPerPop, and it is held in the first column
of the train and test datasets. There are 95 features in each sample. These features include possibly
relevant variables, such as the size of the police force or the percentage of children that graduate
high school. The data have been split for you into a training and test set with 1,595 and 399 entries,
respectively. The features have been standardized to have mean 0 and variance 1.
"""

import numpy as np
import pandas as pd
import math

train_df = pd.read_csv('spam-train',delimiter=',',header=None)
test_df = pd.read_csv('spam-test',delimiter=',',header=None)

# Get responses
y_train = train_df[57]
y_test = test_df[57]
# Get samples
x_train = train_df.drop([57],axis=1)
x_test = test_df.drop([57], axis=1)

# Standardize Data
def standardize(foo):
  return ((foo-foo.mean(axis=0)) / foo.std(axis=0))
x_train = standardize(x_train)
x_test = standardize(x_test)

x_train['Bias'] = np.ones_like(x_train.shape[0])
x_test['Bias'] = np.ones_like(x_test.shape[0])

"""#Train the model"""

def sigmoid(r):
    return 1 / (1 + math.exp(-r))

v_sigmoid = np.vectorize(sigmoid)

# Constants
alpha = 10e-4
threshold = 10e-4
max_epochs = 10**4

# Train the model w/ Logistic Regression
def lg_regr_train(data, alpha, threshold, max_epochs):
  w0 = np.random.normal(0,1,size=x_train.shape[1])
  epoch = 0
  while True:
    w1 = w0 - alpha*(np.dot(x_train.T, (v_sigmoid(np.dot(x_train, w0)) - y_train)))
    if (abs(w1 - w0).max() < threshold) or (epoch >= max_epochs):
      print("Total epochs: ", epoch)
      break
    w0 = w1
    epoch += 1
  return w0

def prediction(sample, model):
  return np.round(v_sigmoid(np.dot(model, sample.T)))

def accuaracy(prediction, actual):
  total = range(len(prediction))
  correct = 0
  for i in total:
    if prediction[i] == actual[i]:
      correct +=1
  return (correct/prediction.shape[0])

trained_model = lg_regr_train(x_train, alpha, threshold, max_epochs)
# Training accuaracy
tr_p = prediction(x_train, trained_model)
print("Training Accuaracy: ", accuaracy(tr_p, y_train)*100, "%")
# Testing accuaracy
te_p = prediction(x_test, trained_model)
print("Testing Accuaracy: ", accuaracy(te_p, y_test)*100, "%")

