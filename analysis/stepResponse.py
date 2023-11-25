import numpy as np
from scipy import signal
import matplotlib.pyplot as plt

# define the system transfer function
K = 1.0
wn = 2.0 * np.pi
zeta = 0.7
num = [K*wn**2]
den = [1, 2*zeta*wn, wn**2]
sys = signal.lti(num, den)

# compute and plot the step response
t, y = signal.step(sys)
plt.plot(t, y)
plt.xlabel('Time (s)')
plt.ylabel('Output')
plt.show()
