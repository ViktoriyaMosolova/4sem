clear
clc
x = [2 2.5 3 3.5 4 4.5 5 5.5 6];
y = [5.197 7.78 11.14 15.09 19.245 23.11 26.25 28.6 30.3];
disp("-------------------------------------------------------------------------");

d1y = diff(y, 1)';
d2y = diff(y, 2)';
d3y = diff(y, 3)';
d4y = diff(y, 4)';
d5y = diff(y, 5)';
d6y = diff(y, 6)';
d7y = diff(y, 7)';
d8y = diff(y, 8)';
%таблица конечных разностей
D = [d1y [d2y;0] [d3y;0;0] [d4y;0;0;0] [d5y;0;0;0;0] [d6y;0;0;0;0;0] [d7y;0;0;0;0;0;0] [d8y;0;0;0;0;0;0;0]]

%оптим. степень
min_value = max(diff(y, 1)) - min(diff(y, 1));
for i = 1:length(x)-2
    if ((max(diff(y, i))-min(diff(y, i))) < min_value)
        index_min = i;
        min_value = max(diff(y, i)) - min(diff(y, i));
    end
end
disp("Оптимальная степень интерполяционного полинома: " + index_min);
%заданные точки
x1 = 3.75;
x2 = 4.75;
x3 = 5.25;
figure();
xx1 = 1.8:0.01:6.2;
yy1 = spline(x,y,xx1);
plot(xx1,yy1, x, y, "*b")
hold on
plot(x1,spline(x,y,x1),"*r")
plot(x2,spline(x,y,x2),"*r")
plot(x3,spline(x,y,x3),"*r")
disp("-------------------------------------------------------------------------");
disp("Значения рассчитанные с помощью сплайн интерполяции:")
disp("x1 = 3.75 y1=" + spline(x,y,x1))
disp("x2 = 4.75 y2=" + spline(x,y,x2))
disp("x3 = 5.72 y3=" + spline(x,y,x3))
