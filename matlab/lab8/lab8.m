clear
clc
%Данные
x = [3.37; 8.08; 11.76; 12.15; 13.25; 14.53];
y = [1.4272;17.6441;63.6593;71.6087;98.4015;139.1986];
p = [0.8;0.9;1;0.6;1;0.7];
xx = [14.34;6.66;12.34];
yy = [132.4013;9.5329;83.7589];

%Определение степени полинома через таблицу конечных разностей
kr = [0,0,0,0];
kr(1)=max(diff(y,1))-min(diff(y,1))
kr(2)=max(diff(y,2))-min(diff(y,2))
kr(3)=max(diff(y,3))-min(diff(y,3))
kr(4)=max(diff(y,4))-min(diff(y,4))
D=min(kr);
for i=1:1:4
    if kr(i)==D
        disp("Степень полинома: " + i);
        steppol=i;        
    end
end
%через Basic Fitting
steppol = 5 
%Находим коэффициенты полинома, аппроксимирующего функцию
koefpol = polyfit(x, y, steppol)
W = vander(x);
%Находим коэффициенты аппроксимирующего полинома
A = W.'*W;
b = W.'*y;
a = inv(A)*b
%Проверка через polyfit
polf = polyfit(x,y,steppol)
x1=3:0.001:15;
y1=a(1)*x1.^5+a(2)*x1.^4+a(3)*x1.^3+a(4)*x1.^2+a(5)*x1.^1+a(6)*x1.^0;
%График функции
plot(x1,y1);
hold on;
plot(xx,yy,'r*');
hold on;

%с использованием spap2 и весовых коэффициентов
%k=5.0;
%knots=length(x)-k;
%sp = spap2(knots,k,x,y,p)
%fnplt(sp);

%с использованием fminsearch и весовых коэффициентов
a_n = polf;
mins = @(a_n)(MinFun(a_n,x,y,p));
newa = fminsearch(mins,a_n);
y3 = a_n(1)*x1.^5 + a_n(2)*x1.^4 +a_n(3)*x1.^3 + a_n(4)*x1.^2 + a_n(5)*x1 +a_n(6);
plot(x1,y3,'-black', 'LineWidth',2);

function m = MinFun(a,x,y,p)
    m=0;
    for i=1:length(x)
        f=p(i)*(y(i)-a(6)-a(5)*x(i)-a(4)*x(i).^2-a(3)*x(i).^3-a(2)*x(i).^4-a(1)*x(i).^5);
    end
end