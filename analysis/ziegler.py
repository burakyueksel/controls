import numpy as np
import matplotlib.pyplot as plt

# define the process model
def process_model(x, u):
    # example model of a first-order system
    tau = 1.0
    k = 2.0
    dxdt = (-x + k*u) / tau
    return dxdt

# define the pid controller function
def pid_control(Kp, Ki, Kd, dt):
    # initialize variables
    x_int = 0.0
    x_prev = 0.0
    e_prev = 0.0
    
    def control(e):
        nonlocal x_int, x_prev, e_prev
        # calculate the control output
        x_int += e*dt
        x_der = (e - e_prev)/dt
        x_ctrl = Kp*e + Ki*x_int + Kd*x_der
        # update variables
        x_prev = x_ctrl
        e_prev = e
        return x_ctrl
    
    return control

# Ziegler-Nichols method to tune PID gains
def ziegler_nichols_tuning(process_model, Kc=1.0):
    # calculate the ultimate gain and period
    u = 1.0
    x0 = 0.0
    T0 = 0.0
    while T0 == 0.0:
        T = np.linspace(0.0, 20.0, 200)
        X = np.zeros_like(T)
        X[0] = x0
        for i in range(1, len(T)):
            dt = T[i] - T[i-1]
            u_ctrl = Kc*process_model(X[i-1], u)
            X[i] = X[i-1] + process_model(X[i-1], u_ctrl)*dt
            if X[i] > 0.8:
                T0 = T[i]
                break
        u *= 0.9
    Ku = 4.0*Kc/(np.pi*X.max())
    Tu = T0/1.8
    # calculate the PID gains
    Kp = 0.6*Ku
    Ki = 1.2*Ku/Tu
    Kd = 0.075*Ku*Tu
    return Kp, Ki, Kd

# simulation parameters
dt = 0.01
t_sim = np.arange(0.0, 10.0, dt)
setpoint = np.sin(t_sim)
process_noise = 0.1*np.random.randn(len(t_sim))

# PID tuning
Kc = 1.0  # critical gain
Kp, Ki, Kd = ziegler_nichols_tuning(process_model, Kc)
print("Kp= ", Kp)
print("Kd= ", Kd)
print("Ki= ", Ki)
pid = pid_control(Kp, Ki, Kd, dt)

# simulation loop
x = np.zeros_like(t_sim)
x[0] = 0.0
for i in range(1, len(t_sim)):
    # calculate the error
    e = setpoint[i] - x[i-1] + process_noise[i]
    # apply the PID controller
    u = pid(e)
    # apply the control input to the process model
    dxdt = process_model(x[i-1], u)
    x[i] = x[i-1] + dxdt*dt

# plot the results
plt.plot(t_sim, setpoint, 'k--', label='setpoint')
plt.plot(t_sim, x, label='process output')
plt.legend()
plt.xlabel('Time (s)')
plt.ylabel('Process variable')
plt.show()