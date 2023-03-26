from scipy.optimize import minimize
import numpy as np
import math
import matplotlib.pyplot as plt

# Используя приведенные данные, подобрать константы в модели Вильсона и построить y-x и P-x диаграмму.
# методика: см. стр. 276-277, первый алгоритм из раздела 8.6 справочника Шервуда (файл VLE_по_справочнику_Шервуда.pdf)
# подсказка: выполните минимизацию функции SUM[abs(gE_exp – gE_Wilson)] 
# по параметрам по модели Вильсона α_12 и α_21 (x0 = [α_12^0 α_21^0] = [10000; 5000], например). 
# Для этого используйте scipy.optimize например, с методом Нелдера-Мида (Nelder-Mead).
# Коэффициенты A, B, C в таблицах приведены для следующего уравнения
# ln Pi0(мм.рт.ст.) = [A - B / ( T (K) + C )] (не забудьте перевести единицы давления после вычисления).

# 2.	Ацетон + хлороформ
# Вариант	2	
# Данные VLE, T =	298.15K
# X1	  Y1	  P, bar
# 0.100	0.055	0.2420
# 0.300	0.275	0.2216
# 0.500	0.589	0.2287
# 0.700	0.780	0.2546
# 0.900	0.951	0.2887
# Параметры	
#  	      1     	2
# A	      16.65	  15.97
# B	      2940.46	2696.79
# C	      -35.93	-46.16
# Tc, K	  508.10	536.40
# Pc, bar	47.01	54.72
# ω	      0.31	0.22

R = 8.314
T = 298.15
A = [16.65,	  15.97]
B = [2940.46,	2696.79]
C = [-35.93,	-46.16]
Tc = [508.10,	536.40]
Pc = [47.01*100000, 54.72*100000]
w = [0.31,	0.22]
x1 = [0.100, 0.300, 0.500, 0.700, 0.900]
y1 = [0.055, 0.275, 0.589, 0.780, 0.951]
P =  [0.2420, 0.2216, 0.2287, 0.2546, 0.2887]

x2 = [1 - x1[0], 1 - x1[1], 1 - x1[2], 1 - x1[3], 1 - x1[4]]
y2 = [1 - y1[0], 1 - y1[1], 1 - y1[2], 1 - y1[3], 1 - y1[4]]

gam1 = [0, 0, 0, 0, 0]
gam2 = [0, 0, 0, 0, 0]
gE_exp = [0, 0, 0, 0, 0]

# Давление паров чистых жидкостей
P1 = math.exp(A[0] - B[0]/(T + C[0]))/750.1 
P2 = math.exp(A[1] - B[1]/(T + C[1]))/750.1
print(P1)
print(P2)

# Начальные Гаммы
for i in range(len(x1)):
    gam1[i] = y1[i] * P[i] /(x1[i] * P1) 
    gam2[i] = y2[i] * P[i] /(x2[i] * P2)

# Избыточная мольная энергия Гиббса
for i in range(len(x1)): 
    gE_exp[i] = R * T *(x1[i] * math.log(gam1[i]) + x2[i] * math.log(gam2[i]))

# Параметр Рэкетта
Zra1 = 0.29056 - 0.08775 * w[0]
Zra2 = 0.29056 - 0.08775 * w[1]

# молярные объёмы чистых жидких компонентов
Vl1 = (R * Tc[0]/(Pc[0])) * math.pow(Zra1, 1 + math.pow((1 - T/Tc[0]), 2/7))
Vl2 = (R * Tc[1]/(Pc[1])) * math.pow(Zra2, 1 + math.pow((1 - T/Tc[1]), 2/7))

def func(alph, Vl1=Vl1, Vl2=Vl2, R=R, T=T, x1=x1, x2=x2, exp=gE_exp):
    # расчет больших лямбд со страницы 21
    lamb12 = Vl2 / Vl1 * math.exp(-alph[0] / (R * T))  
    lamb21 = Vl1 / Vl2 * math.exp(-alph[1] / (R * T))
    sum = 0
    for i in range(len(x1)):
        # c.21 Модель Вильсона gE
        gsol = R * T * (-x1[i] * math.log(x1[i] + lamb12 * x2[i]) - x2[i] * math.log(x2[i] + lamb21 * x1[i]))
        sum += abs(exp[i]-gsol)
    return sum

# расчет гаммы стр 21. нужно для графиков ниже
def gamma1(x1, x2, lmb12, lmb21):  
    return math.exp(-math.log(x1 + lmb12 * x2) + x2 * (lmb12 / (x1 + lmb12 * x2) - lmb21 / (x2 + lmb21 * x1)))

def gamma2(x1, x2, lmb12, lmb21):
    return math.exp(-math.log(x2 + lmb21 * x1) - x1 * (lmb12 / (x1 + lmb12 * x2) - lmb21 / (x2 + lmb21 * x1)))

# график по формулам со страницы 22
mini = minimize(func, x0=[10000, 5000], method='Nelder-Mead').x
print(mini)

parameters = [Vl2 / Vl1 * math.exp(-mini[0] / (R * T)), Vl1 / Vl2 * math.exp(-mini[1] / (R * T))]
n = 1000
X = [x / n for x in range(n + 1)]
P_plt = [P1 * x * gamma1(x, 1.0 - x, parameters[0], parameters[1]) + P2 * (1 - x) * gamma2(x, 1.0 - x, parameters[0], parameters[1])
         for x in X]
Y = [x * gamma1(x, 1.0 - x, parameters[0], parameters[1]) * P1 / p_plt for (x, p_plt) in zip(X, P_plt)]


plt.figure(1)
plt.title("P-x")
plt.xlabel("X(Acetone)")
plt.ylabel("Pressure(bar)")
plt.plot(X, P_plt)
plt.plot(Y, P_plt)
plt.grid
plt.show()

plt.figure(2)
plt.grid
plt.title("y-x")
plt.xlabel("x1, мол. д.")
plt.ylabel("y1, мол. д.")
plt.plot(X, Y)
plt.plot(X, X)
plt.show()
