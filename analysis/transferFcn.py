# https://www.halvorsen.blog/documents/programming/python/resources/powerpoints/Transfer%20Functions%20with%20Python.pdf
import control
import matplotlib.pyplot as plt

s = control.TransferFunction.s
tau = 0.3
damp = 1
H = (1)/((s**2 + 2*tau*damp*s + tau*tau)*(s+tau))
print ('H(s) =', H)
t, y = control.step_response(H)
plt.plot(t,y)
plt.title("Step Response")
plt.grid()
plt.show()