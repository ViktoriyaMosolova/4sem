import matplotlib.pyplot as plt
import math

R = 8.315  # Дж/(моль∙К)
T = 293.7  # K

# Задание 1
t = [0, 300, 900, 1380, 2100, 3300, 7200]  # секунды
Ca = [0.02, 0.0128, 0.00766, 0.0054, 0.00422, 0.00289, 0.00138]  # молярная концентрация C(CH3COOC2H5), моль/л

k = 0.0933 #л/(моль*с)

# Расчёт времени полупревращения
r = 1 / (k * Ca[0])
print('Время полупревращения r1/2: ' + str(r) + ' с')

# Расчёт концентрации вещества при t = 8300 sec
t1 = 8300
C_t1 = Ca[0] / (1 + Ca[0] * k * t1)
print('Концентрация вещества при t = 8300 c: ' + str(C_t1) + ' моль/л')

# Израсходовано вещества
x = (t1*k*Ca[0]**2)/(1+t1*k*Ca[0])

# Расчёт степени превращения
res = x / Ca[0]
print('Степень превращения: ' + str(res))



# Задание 2

k1 = 0.5
k2 = 0.2

delta_t = 0.01
t = [delta_t * i for i in range(0, 400000)]

Ca = [0.017]  # кмоль/м^3
Cb = [0.014]  # кмоль/м^3
Cc = [0]  # кмоль/м^3
Cd = [0]  # кмоль/м^3

for i in range(1, 400000):
	Ca.append(-k1 * Ca[i - 1] * Cb[i - 1] * delta_t + Ca[i - 1])
	Cb.append(-k1 * Ca[i - 1] * Cb[i - 1] * delta_t + Cb[i - 1])
	Cc.append((k1 * Ca[i - 1] * Cb[i - 1] - k2 * Cc[i - 1]) * delta_t + Cc[i - 1])
	Cd.append(k2 * Cc[i - 1] * delta_t + Cd[i - 1])

# Построение графиков
plt.plot(t, Ca, 'red') #C5H10
plt.plot(t, Cb, 'green') #H2
plt.plot(t, Cc, 'blue') #C5H12
plt.plot(t, Cd, 'pink') #i-C5H12
plt.title('График изменения концентрации i-C5H12 при T=const')
plt.xlabel('t, сек')
plt.ylabel('C, кмоль/м^3')
plt.show()

