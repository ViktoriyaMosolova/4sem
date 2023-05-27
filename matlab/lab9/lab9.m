clc;
clear;
%исходные данные----------------------------------------------------------
f = @(x) (x.*x + exp(x+3));
x_data = [10    10.01        10.02      10.03       10.04       10.05];
y_data = [1     13.300787    25.71176   38.21209    50.809229   63.50377]; 

%заданные точки(в моем варианте была задана только 1 точка поэтому добавлю еще 2 свои)
x_set = [10.026 10.036 10.045];
%-------------------------------------------------------------------------
%Табличная функция
poly_table = polyfit(x_data, y_data, 5);
y_poly_d1 = polyval(polyder(poly_table),x_set);
y_poly_d2 = polyval(polyder(polyder(poly_table)),x_set);
%-------------------------------------------------------------------------
%графики табличной функции и производных
figure();
plot(x_data,y_data,'*');
hold on
X = 10:0.001:10.05;
plot(X,polyval(poly_table,X));
plot(X,polyval(polyder(poly_table),X));
plot(X,polyval(polyder(polyder(poly_table)),X));
legend({'Data','f', 'f''', 'f'''''},'Location','northwest');

e = 1e-3;
%простая и многоточечная
f_d1 = @(x,f_set,e) (f_set(x+e)-f_set(x))./e;
f_d2 = @(x,f_set,e) (f_d1(x+e,f_set,e)-f_d1(x,f_set,e))./e;

f_d1_mu = @(x,f_set,e) (f_set(x-2*e)-8*f_set(x-e)+8*f_set(x+e)-f_set(x+2*e))./(12*e);
f_d2_mu = @(x,f_set,e) (f_d1_mu(x-2*e,f_set,e)-8*f_d1_mu(x-e,f_set,e)+...
8*f_d1_mu(x+e,f_set,e)-f_d1_mu(x+2*e,f_set,e))./(12*e);

%расчёт ошибок в точке-----------------------------------------------------
%производные в точке x0
x0 = -3.2;
disp("--------------Производные в точке x0=-3.2---------------------");
d1_sym = matlabFunction(simplify(diff(sym(f),1))); 
d2_sym = matlabFunction(simplify(diff(sym(f),2))); 
an1 = d1_sym(x0);
disp("Первая аналитическая производная = " + an1);
an2 = d2_sym(x0);
disp("Вторая аналитическая производная = " + an2);

f_d1_s = f_d1(x0,f,e);
disp("Первая простая производная = " + f_d1_s);
f_d1_m = f_d1_mu(x0,f,e);
disp("Первая многоточечная производная = " + f_d1_m);
f_d2_s = f_d2(x0,f,e);
disp("Вторая простая производная = " + f_d2_s);
f_d2_m = f_d2_mu(x0,f,e);
disp("Вторая многоточечная производная = " + f_d2_m);
disp("--------------------------------------------------------------");
disp("Ошибки:");
err1_s = abs(f_d1_s-an1);
disp("Первая простая производная = " + err1_s);
err1_m = abs(f_d1_m-an1);
disp("Первая многоточечная производная = " + err1_m);
err2_s = abs(f_d2_s-an2);
disp("Вторая простая производная = " + err2_s);
err2_m = abs(f_d2_m-an2);
disp("Вторая многоточечная производная = " + err2_m);


%--------------------------------------------------------------------------
err_f = @(f,f_d,h,x,func) abs(f_d(x,f,h)-func(x)); 

%графики зависимости ошибки первой и второй производной от величины шага
H = 0.5:-1e-5:1e-5;
figure(2);
plot(H,err_f(f,f_d1,H,x0,d1_sym));
hold on;
plot(H,err_f(f,f_d1_mu,H,x0,d1_sym));
title('f''(x0) error');
xlabel('H');
ylabel('ERROR');
legend({'Single-dot','Multi-dot'},'Location','northwest');

figure();
plot(H,err_f(f,f_d2,H,x0,d2_sym));
hold on;
plot(H,err_f(f,f_d2_mu,H,x0,d2_sym));
title('f''''(x0) error');
xlabel('H');
ylabel('ERROR');
legend({'Single-dot','Multi-dot'},'Location','northwest');

%графики абсолютных ошибок первой и второй производной--------------------
X = 5:0.01:15;
figure();
hold on;
plot(X,err_f(f,f_d1,e,X,d1_sym));
plot(X,err_f(f,f_d1_mu,e,X,d1_sym));
title('f''(x0) absolute error');
legend({'Single-dot error', 'Multi-dot error'},'Location','northwest');

figure();
hold on;
plot(X,err_f(f,f_d2,e,X,d2_sym));
plot(X,err_f(f,f_d2_mu,e,X,d2_sym));
title('f''''(x0) absolute error');
legend({'Single-dot error', 'Multi-dot error'},'Location','northwest');
%-------------------------------------------------------------------------

