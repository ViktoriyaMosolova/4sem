clc
clear
syms xs ys;

yd = (ys.^2)/(xs.^3) + xs;
yr1 = xs.^2*((1/log(xs))-2);
disp('Проверка разности значения производной из ДУ и производных представленных функций:')
disp(simplify(subs(yd, ys, yr1) - diff(yr1)));

% Определение дифференциального уравнения
f = @(x, y) y^2/(x*y + x^3);

% Начальные условия
x0 = 1;
y0 = 1;

% Отрезок интегрирования
a = 1;
b = 2;

% Численное интегрирование методом Эйлера
[x1, y1, err_abs_euler_1] = euler(f, y0, a, b, 0.02);
[x2, y2, err_abs_euler_2] = euler(f, y0, a, b, 0.005);
figure(1);
plot(x1, y1, x2, y2);
hold on;
[x1, y1_2] = euler(f, y0, a, b, 0.02/2);
[x2, y2_2] = euler(f, y0, a, b, 0.005/2);
% Вычисление погрешностей методом Эйлера
err1 = abs(y1(end) - y1_2(end))/3;
err2 = abs(y2(end) - y2_2(end))/3;
err_abs1 = abs(sqrt(b^2 + 1) - y1(end));
err_abs2 = abs(sqrt(b^2 + 1) - y2(end));

% Численное интегрирование методом Рунге-Кутты 4-го порядка
[x3, y3, err_abs_rk4_1] = runge_kutta(f, y0, a, b, 0.02);
[x4, y4, err_abs_rk4_2] = runge_kutta(f, y0, a, b, 0.005);
plot(x3, y3, x4, y4);
[x3, y3_2] = runge_kutta(f, y0, a, b, 0.02/2);
[x4, y4_2] = runge_kutta(f, y0, a, b, 0.005/2);
% Вычисление погрешностей методом Рунге-Кутты
p = 4; % порядок метода Рунге-Кутты
err3 = abs(y3(end) - y3_2(end))/(2^p - 1);
err4 = abs(y4(end) - y4_2(end))/(2^p - 1);
err_abs3 = abs(sqrt(b^2 + 1) - y3(end));
err_abs4 = abs(sqrt(b^2 + 1) - y4(end));

% Вычисление решения стандартным оператором MATLAB
[t, y5] = ode45(f, [a, b], y0);
plot(t, y5);
% Вывод погрешностей на экран
fprintf('Error for Euler method with h = 0.02: %f\n', err1);
fprintf('Error for Euler method with h = 0.005: %f\n', err2);
fprintf('Error for Runge-Kutta method with h = 0.02: %f\n', err3);
fprintf('Error for Runge-Kutta method with h = 0.005: %f\n', err4);
fprintf('Absolute error for Euler method with h = 0.02: %f\n', err_abs1);
fprintf('Absolute error for Euler method with h = 0.005: %f\n', err_abs2);
fprintf('Absolute error for Runge-Kutta method with h = 0.02: %f\n', err_abs3);
fprintf('Absolute error for Runge-Kutta method with h = 0.005: %f\n', err_abs4);

% Построение графика
legend('Euler 0.02', 'Euler 0.005', 'RK4 0.02', 'RK4 0.005', 'ode45');
xlabel('x');
ylabel('y');
% Задание набора шагов
h_vals = [0.02, 0.005];

len1 = 1:1:((b-a)/h_vals(1));
len2 = 1:1:(b-a)/h_vals(2);
% Построение графика абсолютной погрешности по всему интервалу
figure;
loglog(len1, err_abs_euler_1, '--', 'LineWidth', 1.5,  'Color', 'blue');
hold on;
loglog(len2, err_abs_euler_2, '--', 'LineWidth', 2, 'Color', 'black');
loglog(len1, err_abs_rk4_1, '--', 'LineWidth', 1.5,'Color', 'green');
loglog(len2, err_abs_rk4_2, '--', 'LineWidth', 1.5,  'Color', 'magenta');
grid on;
xlabel('Итерация');
ylabel('Абсолютная погрешность');
title('Абсолютная погрешность решения');
legend('Метод Эйлера h = 0.02', 'Метод Эйлера h = 0.005','Метод Рунге-Кутты 4-го порядка h = 0.02','Метод Рунге-Кутты 4-го порядка h = 0.005');
function [x, y, err_abs_euler] = euler(f, y0, a, b, h)
% Метод Эйлера
x = a:h:b;
y = zeros(size(x));
y(1) = y0;
for i = 1:length(x)-1
    y(i+1) = y(i) + h*f(x(i), y(i));
    err_abs_euler(i) = abs(sqrt(x(i)^2 + 1) - y(i+1));
end
end

function [x, y, err_abs_rk4] = runge_kutta(f, y0, a, b, h)
% Метод Рунге-Кутты 4-го порядка
x = a:h:b;
y = zeros(size(x));
y(1) = y0;
for i = 1:length(x)-1
    k1 = h*f(x(i), y(i));
    k2 = h*f(x(i) + h/2, y(i) + k1/2);
    k3 = h*f(x(i) + h/2, y(i) + k2/2);
    k4 = h*f(x(i) + h, y(i) + k3);
    y(i+1) = y(i) + (k1 + 2*k2 + 2*k3 + k4)/6;
    err_abs_rk4(i) = abs(sqrt(x(i)^2 + 1) - y(i+1));
end
end