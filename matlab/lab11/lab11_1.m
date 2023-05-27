clc; 
clear;

g = (1 + sqrt(5))/2;
xx = linspace(9.01, 9.1);
plot(xx, f(xx));
hold on;

a = 0.0001;
b = 2500;
e = 0.001;
g=(sqrt(5)-1)/2; 
k2=1-g;
x1=g*a+k2*b; 
x2=k2*a+g*b;
A=f(x1); 
B=f(x2);
xs = a;
count = 0;
while 1
    count = count + 1;
    if A<B
        b=x2;
        if b-a<e 
            xs = x1;
            break
        else
            x2=x1; 
            B=A; 
            x1=g*a+k2*b; 
            A=f(x1);
        end
    else
        a=x1;
        if b-a<e
            xs = x2;
            break
        else
            x1=x2; 
            A=B; 
            x2=k2*a+g*b; 
            B=f(x2);
        end
    end
end
disp('Методом золотого сечения:');
disp(xs);
disp('Количество итераций:');
disp(count);
scatter(xs, f(xs));
hold on;

h = 2*e;
xp = a;
xo = xp;
count = 0;
while 1
    count = count + 1;
    xo=xp-0.5*h*((f(xp+h)-f(xp-h))/...
        (f(xp+h)-2*f(xp)+f(xp-h)));
    if abs(xo - xp) < e
        break
    end
    xp = xo;
end
disp('Методом парабол:');
disp(xp);
disp('Количество итераций:');
disp(count);
scatter(xp, f(xp));
hold on;

syms x;
fd1 = diff(f(x));
fd2 = diff(fd1);
xn = a;
F1 = @(n)(double(vpa(subs(fd1, n))));
F2 = @(n)(double(vpa(subs(fd2, n))));
count = 0;
while 1
   count = count + 1;
   x1 = xn - F1(xn)/F2(xn);
   if abs(x1 - xn) < e
       break
   end
   xn = x1;
end
disp('Методом Ньютона:');
disp(xn);
disp('Количество итераций:');
disp(count);
scatter(xn, f(xn));
hold on;

x = fminbnd(@f, 9.01, 9.1);
disp('Стандартными функциями:');
disp(x);
disp('Разница с золотым сечением:');
disp(abs(x - xs));
disp('Разница с параболами:');
disp(abs(x - xp));
disp('Разница с Ньютона:');
disp(abs(x - xn));
grid on;

function s = f(h)
s = pi.^(1/2) .* h.^(1/2) * 60 + 900 ./ h * 1.61;
end
