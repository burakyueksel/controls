import numpy as np
import matplotlib.pyplot as plt
import scipy.signal as signal

# System parameters
K = 1
zeta = 0.5
omega_n = 2*np.pi*1
tau_d = 0.5

# Second-order transfer function with delay
num_sys = [K*tau_d**(-2), 0, K*omega_n**2]
den_sys = [1, 2*zeta*omega_n, omega_n**2, tau_d**(-2), 2*zeta*omega_n*tau_d**(-1), omega_n**2*tau_d**(-2)]
sys = signal.lti(num_sys, den_sys)

# PID controller parameters
Kp = 2
Ki = 1
Kd = 0.5

# PID controller transfer function
num_pid = [Kd, Kp, Ki]
den_pid = [1, 0]
pid = signal.lti(num_pid, den_pid)

# Feedback loop transfer function
num_loop = np.convolve(num_sys, num_pid)
den_loop = np.convolve(den_sys, den_pid)
loop = signal.lti(num_loop, den_loop)

# Input signal
t = np.linspace(0, 10, 1000)
u = np.zeros(len(t))
u[int(len(t)/2):] = 1

# Compute closed-loop response
t_loop, y_loop, _ = signal.lsim(loop, U=u, T=t)

# Plot results
plt.plot(t, u, label='Input')
plt.plot(t_loop, y_loop, label='Output')
plt.xlabel('Time (s)')
plt.ylabel('Amplitude')
plt.legend()
plt.show()
