# -*- coding: utf-8 -*-
"""
Symbolic linarization of nonlinear state-space models
Source: https://aleksandarhaber.com/symbolic-and-automatic-linearization-of-nonlinear-systems-in-python-by-using-sympy-library/

"""
import numpy as np
from sympy import *

# symbolic state vector
x = MatrixSymbol('x',2,1)
# symbolic input
u=symbols('u')
# symbolic constants
g,l,m = symbols('g,l,m') 

# define the nonlinear state equation of a pendulum
stateFunction=Matrix([[x[1]],[-(g/l)*sin(x[0])+(1/(m*l))*(u**2)]])

# compute the Jacobians
JacobianState= stateFunction.jacobian(x)   
JacobianInput= stateFunction.jacobian([u])

# linearization points
statePoint=np.array([[0],[0]])
inputPoint=1


# first approach, using subs
Amatrix=JacobianState.subs(x, Matrix(statePoint))
Bmatrix=JacobianInput.subs(u, inputPoint)

# we can also substitute the constants
Amatrix=Amatrix.subs({g:9.81,l:1})
Bmatrix=Bmatrix.subs({l:1,m:1})

print(Amatrix)
print(Bmatrix)

# second approach, using lambdify
JacobianState2=JacobianState.subs({g:9.81,l:1})
JacobianInput2=JacobianInput.subs({l:1,m:1})
AmatrixFunction=lambdify(x,JacobianState2)
BmatrixFunction=lambdify(u,JacobianInput2)

Amatrix2=AmatrixFunction(statePoint)
Bmatrix2=BmatrixFunction(inputPoint)

print(Amatrix2)
print(Bmatrix2)