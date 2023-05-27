clc;
clear;

%%так как у нас функция двух переменных то n = 2
F = @(x, y)(2+(x.^2-cos(18*x.^2))+(y.^2-cos(18*y.^2)));
[x,y]=meshgrid(-2:0.1:2);

Fx = F(x, y);
surf(x,y,Fx);

x = [0 0];
h = 0.5;
e = 0.0001;
syms xs ys
g = gradient(F(xs, ys), [xs ys]);
count = 0;
while 1
   count = count +1;
   gn = [double(subs(g(1), [xs ys], x)) double(subs(g(2), [xs ys], x))];
   x1 = x - h * gn;
   if abs(x1 - x) < e
       break
   end
   x = x1;
   h = h/1.1;
end
disp('Методом градиентного спуска:');
disp(x1);
disp('Количество итераций:');
disp(count);

hold on;
scatter3(x1(1), x1(2), F(x1(1), x1(2)), 80, 'red');

xm = fminsearch(@(n)(F(n(1),n(2))), x);
disp('Стандартными функциями:');
disp(xm);
disp('Разница с методом градиентного спуска:');
disp(abs(x1 - xm));