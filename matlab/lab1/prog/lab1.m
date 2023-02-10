a=1;
b=2;
solution1=a/b;
solution2=a*b;
help
who
clc
clear
version
one=[1 2 3;1 2 3];
two=[1 1;2 2;3 3];
res=mtimes(one,two);
res1=transpose(one);
res2=power(two, 5);
syms x y
(x-y)*(x-y)^2;
simplify ((x^3-y^3)/(x-y))
cos (pi/2)
cos (sym(pi/2))
sym('1/2')+sym('1/3');
3^45
vpa(3^45)
vpa('3^45')
ezplot('x^3-x', [-4 4]);
ezplot('sin(1/x^2)', [-2 2]);
ezplot('tan(x/2)');
axis([-pi pi -10 10])
ezplot('exp(-x^2/2)', [-1.5 1.5]);
hold on
ezplot('x^4-x^2', [-1.5 1.5]);
hold off
title 'y=exp(-x^2/2) and y=x^4-x^2';