#https://dynamics-and-control.readthedocs.io/en/latest/1_Dynamics/8_Frequency_domain/Frequency%20response%20plots.html#Bode
import numpy
import matplotlib.pyplot as plt

omega = numpy.logspace(-2, 2, 1000)
s = omega*1j

tau1 = 2

G1 = 1/(tau1*s + 1)

tau = 1
zeta = 0.5
G2 = 1/(tau**2*s**2 + 2*tau*zeta*s + 1)

def bode(G):
    fig, [ax_mag, ax_phase] = plt.subplots(2, 1)
    ax_mag.loglog(omega, numpy.abs(G))
    ax_phase.semilogx(omega, numpy.unwrap(numpy.angle(G)))
    plt.show()

def nyquist(G):
    plt.plot(G.real, G.imag,
             G.real, -G.imag)
    plt.xlabel('Real')
    plt.ylabel('Imag')
    plt.axis('equal')
    plt.show()

#bode(G1)
#bode(G2)
#bode(G1*G2)

#nyquist(G1)
#nyquist(G2)
#nyquist(G1*G2)

import control
G = control.tf(1, [tau**2, 2*tau*zeta,1])
control.bode(G, omega); plt.show()
control.nyquist_plot(G, omega); plt.show()