import numpy as np
from scipy import signal

# Define the transfer function of the system
#num = [1]
#den = [1, 1, 1]
#sys = signal.lti(num, den)

# Define the state-space representation of the system
A = np.array([[0, 1], [-1, -1]])
B = np.array([[0], [1]])
C = np.array([[1, 0]])
D = np.array([[0]])

sys = signal.StateSpace(A, B, C, D)

# Define desired poles
desired_poles = [-1, -2]

# Compute feedback gain matrix using pole placement
K = signal.place_poles(A, B, desired_poles).gain_matrix

# Define input and initial state
t = np.linspace(0, 10, num=1001)
u = np.ones_like(t)
x0 = [0, 0]

# Simulate the closed-loop response
Acl = A - B @ K
Bcl = B
Ccl = C
Dcl = D
cl_sys = signal.StateSpace(Acl, Bcl, Ccl, Dcl)
t_cl, y_cl, _ = signal.lsim(cl_sys, U=u, T=t, X0=x0)

# Plot the results
import matplotlib.pyplot as plt
plt.plot(t_cl, y_cl)
plt.xlabel('Time (s)')
plt.ylabel('Output')
plt.title('Closed-loop response with pole placement')
plt.show()