clc;
clear;
%исходные данные----------------------------------------------------------
y = @(x) (x.^2 + exp(x+3));
a=-2;
b=-1;
xl = linspace(a, b);
figure();
plot(xl, y(xl));

disp("-----------------------------Задание 1----------------------------");
disp("а) Аналитическое решение");
disp(" ");
syms x_int;
res_int = int(x_int.^2 + exp(x_int+3), x_int, [a b]);
disp("Решение int = " + double(vpa(res_int)));
disp(" ");
%------------------------------------------------------------------------
disp("1-4 производные:");
syms xs as;
yd(1) = diff(y(xs));
for i = 2:4
   yd(i) = diff(yd(i-1));
end
disp(yd);
%------------------------------------------------------------------------
disp("б) Метод трапеций");
disp(" ");
e = 10e-2;
disp("Точность eps = "+e);
M2 = max(arrayfun(@(x)(abs(double(vpa(subs(yd(2), x))))), xl));
disp('Макимальное значение второй производной:');
disp(M2);
h = sqrt((12*e)/((b - a) * M2));
disp("Шаг интегрирования по формуле: "+h);

se=0;
n = ceil((b - a) / h);
h = (b - a) / n;
for i = a:h:b-h
    se = se + 0.5*h*(y(i) + y(i+h));
end
disp("Интеграл методом трапеций (для шага " + h + "):");
disp(se);


h_arr(1) = sqrt((12*e)/((b - a) * M2));
for i = 2:15
    h_arr(i) = h_arr(i-1) / 2;
end
disp("Исследование влияния шага h на точность интегрирования:");
s = 0;
for k = 1:1:15
    for i = a:h_arr(k):b-h_arr(k)
        s = s + 0.5*h_arr(k)*(y(i) + y(i+h_arr(k)));
    end
    res_tr(k) = s;
    n_arr(k) = (b-a)/h_arr(k);
    tochn(k) = abs(s - double(vpa(res_int)));
    s=0;
end
figure();
loglog(n_arr', tochn');
xlabel('n');
ylabel('точность');
title('график зависимости точности от количества шагов для метода трапеций');
%-------------------------------------------------------------------------
disp("в) Метод Симпсона:");
disp(" ");
e = 10e-4;
disp("Точность eps = "+e);
M4 = max(arrayfun(@(x)(abs(double(vpa(subs(yd(4), x))))), xl));
disp('Макимальное значение четвёртой производной:');
disp(M4);

h = ((180*e)/((b-a)*M4))^(1/4);
disp("Шаг интегрирования по формуле: "+h);

n = ceil((b - a) / (2*h));
h = (b - a) / (2*n);
s1e = 0;
for i = a:2*h:b-2*h
    s1e = s1e + h/3*(y(i)+4*y(i+h)+y(i+2*h));
end
disp("Интеграл методом Симпсона (для шага " + h + "):");
disp(s1e);

h_arr(1) = ((180*e)/((b-a)*M4))^(1/4);
for i = 2:15
    h_arr(i) = h_arr(i-1) / 2;
end
disp("Исследование влияния шага h на точность интегрирования:");
s1 = 0;
for k = 1:1:15
    for i = a:2*h_arr(k):b-2*h_arr(k)
        s1 = s1 + h_arr(k)/3*(y(i)+4*y(i+h_arr(k))+y(i+2*h_arr(k)));
    end
    res_tr(k) = s1;
    n_arr(k) = (b-a)/h_arr(k);
    tochn(k) = abs(s1 - double(vpa(res_int)));
    s1=0;
end
figure();
loglog(n_arr', tochn');
xlabel('n');
ylabel('точность');
title('график зависимости точности от количества шагов для метода симпсона');


disp("г) Стандартные функции Matlab(integral):");
s2 = integral(y, a, b);
disp(s2);
disp('Разница между стандратными и Трапециями:');
disp(abs(se - s2));    
disp('Разница между стандратными и Симпсоном:');
disp(abs(s1e - s2));     

disp("-----------------------------Задание 2----------------------------");
disp('Неопределённый интеграл:');
disp(int(as^xs*exp(-xs), xs));

disp("-----------------------------Задание 3----------------------------");
e = 10e-4;
h = 2;
a = 0;
b = h;
s = quad(@(x)(1+x)./(x+2).^3, a, b);
s2 = s;
while 1
    b = b + h;
    s = quad(@(x)(1+x)./(x+2).^3, a, b);
    if abs(s - s2) < e
        break;
    end
    s2 = s;
end
disp('Несобственный интеграл (1+x)./(x+2).^3 :');
disp(s);

e = 0.1;
h = 2;
a = 0;
b = h;
s = quad(@(x)(sin(x).*cos(x)), a, b);
s2 = s;
while 1
    b = b + h;
    s = quad(@(x)(sin(x).*cos(x)), a, b);
    if abs(s - s2) < e
        break;
    end
    s2 = s;
end

disp('(Доп)Несобственный интеграл sin(x).*cos(x):');
disp(s);

