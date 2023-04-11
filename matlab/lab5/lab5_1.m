clc
clear
disp('--------------------------------------------');
fprintf('Метод перебора + ПИ: f = x - exp(-x)\n');
%Локализация корня методом перебора
disp("Локализация корня методом перебора:")
f=inline('x - exp(-x)');
X=0;
h=0.1;
xh=X+h;
while f(X)*f(xh)>0
    X=xh;
    xh=X+h;
end
disp("Интервал: "+X+" ; "+xh);
disp('--------------------------------------------');
%Метод простых итераций
disp("Метод простых итераций")
f=inline('x - exp(-x)');
fa=inline('exp(-x)');
fda=inline('-exp(-x)');
eps=0.0001;
disp("Заданная точность:" + eps);
x0=X;
x=0;
N=0;
if abs(fda(x0))<1 %Проверка условия сходимости
    while abs(x-x0)>eps
        x0=x;
        x=fa(x0);
        N=N+1;
    end
end
disp("Полученное X: " + x);
disp("Количество итераций: " + N);
disp('--------------------------------------------');
%График
Xstep=x-h:0.0001:xh+h;
f = Xstep - exp(-Xstep);
hold on
plot(Xstep, f);
plot(x,0,'*r');
grid on
%Проверка решения
f=inline('x - exp(-x)');
disp("Проверка решения уравнения: f(x)= " + f(x));
disp('--------------------------------------------');
%Расчет решения используя стандартные операторы MATLAB
disp("Решение fzero с точностью "+eps+":"); 
[x_fzero,fval,exitflag,output] = fzero(f, X, optimset('Display','off','TolX',0.0001));
disp("X="+x_fzero);
disp("Вывод доп. информации: ");
disp(output);
disp("Решение fsolve с точностью "+eps+":");
[xfsolve,fval,exitflag,output] = fsolve(f, X, optimset('Display','off','TolX',0.0001));
disp("X="+xfsolve);
disp("Вывод доп. информации: ");
disp(output);
disp('--------------------------------------------');
%Используя символьную математику
syms x;
f = x - exp(-x)==0;
disp("Решение через символьную математику. X: "+double(vpasolve(f)));
disp('--------------------------------------------');
%%
clear
clc
fprintf('Метод перебора + Хорд: f = x - cos(x)\n');
%Локализация корня методом перебора
disp("Локализация корня методом перебора:")
f=inline('x - cos(x)');
X=0;
h=0.1;
xh=X+h;
while f(X)*f(xh)>0
    X=xh;
    xh=X+h;
end
disp("Интервал: "+X+" ; "+xh);
disp('--------------------------------------------');
%Метод хорд
disp("Метод хорд")
f=inline('x - cos(x)');
f2=inline('cos(x)');
eps=0.0001;
disp("Заданная точность:" + eps);
x0=X;
x=0;
N=0;
b=X;
a=xh;
modab=abs(a-b);
%%для выполнения условия поменяли местами границы a и b.
if f(a)*f2(a)>0 %Проверка условия сходимости
    while modab>eps
       x=a-(f(a)*(b-a))/(f(b)-f(a));
       if f(a)*f(x)<0
           b=x;
       end
       if f(b)*f(x)<0
           a=x;
       end
       modab=abs(x-x0);
       x0=x;
       N=N+1;
    end    
end  
disp("Полученное X: " + x);
disp("Количество итераций: " + N);
%График
Xstep=x-h:0.0001:xh+h;
f = Xstep - cos(Xstep);
hold on
plot(Xstep, f);
plot(x,0,'*r');
grid on
%Проверка решения
f=inline('x - cos(x)');
disp("Проверка решения уравнения: f(x)= " + f(x));
disp('--------------------------------------------');
%Расчет решения используя стандартные операторы MATLAB
disp("Решение fzero с точностью "+eps+":"); 
[x_fzero,fval,exitflag,output] = fzero(f, X, optimset('Display','off','TolX',0.0001));
disp("X="+x_fzero);
disp("Вывод доп. информации: ");
disp(output);
disp("Решение fsolve с точностью "+eps+":");
[xfsolve,fval,exitflag,output] = fsolve(f, X, optimset('Display','off','TolX',0.0001));
disp("X="+xfsolve);
disp("Вывод доп. информации: ");
disp(output);
disp('--------------------------------------------');
%Используя символьную математику
syms x;
f = x - cos(x)==0;
disp("Решение через символьную математику. X: "+double(vpasolve(f)));
disp('--------------------------------------------');
%%
clear
clc
fprintf('Метод перебора + Касательных: f = x - x^2-1\n');
%Локализация корня методом перебора
disp("Локализация корня методом перебора:")
f=inline('x - x^2+1');
X1=-10;
h=0.1;
xh1=X1+h;
while f(X1)*f(xh1)>0
   X1=xh1;
   xh1=X1+h;
   if(f(X1)*f(xh1)<0)
     disp("Интервал: "+X1+" ; "+xh1);
   end
end
X2=0;
xh2=X2+h;
while f(X2)*f(xh2)>0
   X2=xh2;
   xh2=X2+h;
   if(f(X2)*f(xh2)<0)
      disp("Интервал: "+X2+" ; "+xh2);
   end
end
disp('--------------------------------------------');
disp("Метод касательных (Ньютона)")
f=inline('x - x^2+1');
fd=inline('1-2*x');
f2=inline('-2');
temp=1;
x0=X1;
x1=0;
N=0;
eps=0.0001;
disp("Заданная точность:" + eps);%Проверка условия сходимости
%за х0 взяли левую границу интервала для выполнения условия
if f(X1)*f2(X1)>0 %Проверка условия сходимости+++
    while temp>eps 
        x1=x0-f(x0)/fd(x0);
        temp=abs(x0-x1);
        x0=x1;
        N=N+1;
        if(N > 1000) 
            break;
        end
    end
end
disp("Полученное X1: " + x1);
disp("Количество итераций: " + N);
%Проверка решения
disp("Проверка решения уравнения: f(x)= " + f(x1));
temp=1;
x0=xh2;
x2=0;
N=0;
eps=0.0001;
%за х0 взяли правую границу интервала для выполнения условия
if f(xh2)*f2(xh2)>0 %Проверка условия сходимости+++
    while temp>eps 
        x2=x0-f(x0)/fd(x0);
        temp=abs(x0-x2);
        x0=x2;
        N=N+1;
        if(N > 1000) 
            break;
        end
    end
end
disp("Полученное X2: " + x2);
disp("Количество итераций: " + N);
%Проверка решения
disp("Проверка решения уравнения: f(x)= " + f(x2));
%График
Xstep=X1-h:0.0001:xh2+h;
f = Xstep - Xstep.^2+1;
hold on
plot(Xstep, f);
plot(x1,0,'*r');
plot(x2,0,'*r');
grid on
disp('--------------------------------------------');
f=inline('x - x^2+1');
%Расчет решения используя стандартные операторы MATLAB
disp("Решение fzero с точностью "+eps+":"); 
[x_fzero,fval,exitflag,output] = fzero(f, X1, optimset('Display','off','TolX',0.0001));
disp("X="+x_fzero); disp("Вывод доп. информации: "); disp(output);
[xfsolve,fval,exitflag,output] = fzero(f, xh2, optimset('Display','off','TolX',0.0001));
disp("X="+xfsolve); disp("Вывод доп. информации: "); disp(output);

disp("Решение fsolve с точностью "+eps+":");
[x_fzero,fval,exitflag,output] = fsolve(f, X1, optimset('Display','off','TolX',0.0001));
disp("X="+x_fzero); disp("Вывод доп. информации: "); disp(output);
[xfsolve,fval,exitflag,output] = fsolve(f, xh2, optimset('Display','off','TolX',0.0001));
disp("X="+xfsolve); disp("Вывод доп. информации: "); disp(output);
disp('--------------------------------------------');
%Используя символьную математику
syms x;
f = x - x^2+1==0;
disp("Решение через символьную математику. X: "+double(solve(f)));
disp('--------------------------------------------');
%%
clear
clc
fprintf('Метод перебора + Секущих: f = x - 2*exp(-x)\n');
%Локализация корня методом перебора
disp("Локализация корня методом перебора:")
f=inline('x - 2*exp(-x)');
X=-10;
h=0.1;
xh=X+h;
while f(X)*f(xh)>0
    X=xh;
    xh=X+h;
end
disp("Интервал: "+X+" ; "+xh);
disp('--------------------------------------------');
disp("Метод секущих")
f=inline('x - 2*exp(-x)');
f2=inline('-2*exp(-x)');
temp=1;
x0=X;
x=0;
N=0;
x01=0;
eps=0.0001;
disp("Заданная точность:" + eps);%Проверка условия сходимости
%для выполнения условия взяли за x0 левую границу интервала
if f(x0)*f2(x0)>0 %Проверка условия сходимости+++
    while temp>eps 
            x=x0-(f(x0)*(x0-x01))/(f(x0)-f(x01));
            x01=x0;
            temp=abs(x0-x);
            x0=x;
            N=N+1;
    end
end
disp("Полученное X: " + x);
disp("Количество итераций: " + N);
%Проверка решения
disp("Проверка решения уравнения: f(x)= " + f(x));
%График
Xstep=X-h:0.0001:xh+h;
f = Xstep - 2*exp(-Xstep);
hold on
plot(Xstep, f);
plot(x,0,'*r');
grid on
disp('--------------------------------------------');
%Расчет решения используя стандартные операторы MATLAB
f=inline('x - 2*exp(-x)');
disp("Решение fzero с точностью "+eps+":"); 
[x_fzero,fval,exitflag,output] = fzero(f, X, optimset('Display','off','TolX',0.0001));
disp("X="+x_fzero); disp("Вывод доп. информации: "); disp(output);
disp("Решение fsolve с точностью "+eps+":");
[xfsolve,fval,exitflag,output] = fsolve(f, X, optimset('Display','off','TolX',0.0001));
disp("X="+xfsolve); disp("Вывод доп. информации: "); disp(output);
disp('--------------------------------------------');
%Используя символьную математику
syms x;
f = x - 2*exp(-x)==0;
disp("Решение через символьную математику. X: "+double(solve(f)));
disp('--------------------------------------------');
%%
clear
clc
fprintf('Метод перебора + Половинного деления: f = x - exp(-3*x)\n');
%Локализация корня методом перебора
disp("Локализация корня методом перебора:")
f=inline('x - exp(-3*x)');
X=0;
h=0.1;
xh=X+h;
while f(X)*f(xh)>0
    X=xh;
    xh=X+h;
end
disp("Интервал: "+X+" ; "+xh);
disp('--------------------------------------------');
disp("Метод Половинного деления");
f=inline('x - exp(-3*x)');
x=0;
N=0;
eps=0.0001;
disp("Заданная точность:" + eps);
a = X;
b = xh; 
c = (b + a) / 2;
if f(a)*f(b)<0%Проверка условия сходимости
    while (b-a)>eps 
        c = (b + a) / 2;
        N=N+1;
        if f(a)*f(c) < 0
            b = c;
        else
            a = c;
        end
    end
end
x=c;
disp("Полученное X: " + x);
disp("Количество итераций: " + N);
%Проверка решения
disp("Проверка решения уравнения: f(x)= " + f(x));
%График
Xstep=X-h:0.0001:xh+h;
f = Xstep - exp(-3*Xstep);
hold on
plot(Xstep, f);
plot(x,0,'*r');
grid on
disp('--------------------------------------------');
%Расчет решения используя стандартные операторы MATLAB
f=inline('x - exp(-3*x)');
disp("Решение fzero с точностью "+eps+":"); 
[x_fzero,fval,exitflag,output] = fzero(f, X, optimset('Display','off','TolX',0.0001));
disp("X="+x_fzero); disp("Вывод доп. информации: "); disp(output);
disp("Решение fsolve с точностью "+eps+":");
[xfsolve,fval,exitflag,output] = fsolve(f, X, optimset('Display','off','TolX',0.0001));
disp("X="+xfsolve); disp("Вывод доп. информации: "); disp(output);
disp('--------------------------------------------');
%Используя символьную математику
syms x;
f = x - exp(-3*x)==0;
disp("Решение через символьную математику. X: "+double(solve(f)));
disp('--------------------------------------------');