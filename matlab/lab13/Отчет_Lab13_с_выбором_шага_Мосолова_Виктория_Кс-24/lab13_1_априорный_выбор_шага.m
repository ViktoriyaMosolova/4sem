clc
clear
%Реализовать апостериорную или априорную стратегию выбора шага интегрирования.
disp('Задание 1');
f1 = @(x,y1,y2) y1.*exp(-x.^2) + x.*y2;
f2 = @(x,y1,y2) 3.*x-y1+2.*y2;

y1(1)=1;
y2(1)=1;
x(1)=0;

h = 0.1;
eps=0.001;
disp('Начальный шаг h=0.1, точность eps=0.001');
disp(' ');

xkonechnoe = 1;
N = xkonechnoe/h;

% m. Eilera
disp('Метод Эйлера априорный выбор шага');
for i=1:N
    y1(i+1) = y1(i) + h*f1(x(i),y1(i),y2(i));
    y2(i+1) = y2(i) + h*f2(x(i),y1(i),y2(i));
    x(i+1) = x(i) + h;
end

y1_half(1) = 1;
y2_half(1) = 1;
x_half(1) = 0;
N_half = xkonechnoe/(h/2);
for i=1:N_half
    y1_half(i+1) = y1_half(i) + (h/2)*f1(x_half(i),y1_half(i),y2_half(i));
    y2_half(i+1) = y2_half(i) + (h/2)*f2(x_half(i),y1_half(i),y2_half(i));
    x_half(i+1) = x_half(i) + h/2;
end

% Проверка условия на выбор шага и повторный расчет, если условие не выполняется
while max(abs(y1_half(1:2:end)-y1(1:end))) > eps || max(abs(y2_half(1:2:end)-y2(1:end))) > eps
    h = h/2;
    N = xkonechnoe/h;
    for i=1:N
        y1(i+1) = y1(i) + h*f1(x(i),y1(i),y2(i));
        y2(i+1) = y2(i) + h*f2(x(i),y1(i),y2(i));
        x(i+1) = x(i) + h;
    end
    
    y1_half(1) = 1;
    y2_half(1) = 1;
    x_half(1) = 0;
    N_half = xkonechnoe/(h/2);
    for i=1:N_half
        y1_half(i+1) = y1_half(i) + (h/2)*f1(x_half(i),y1_half(i),y2_half(i));
        y2_half(i+1) = y2_half(i) + (h/2)*f2(x_half(i),y1_half(i),y2_half(i));
        x_half(i+1) = x_half(i) + h/2;
    end
end

% Вывод результата
disp(['Решение на конечной точке: y1 = ', num2str(y1(end)), ', y2 = ', num2str(y2(end))]);
x_eiler = x;
y1_eiler = y1;
y2_eiler = y2;

clearvars -except x_eiler y1_eiler y2_eiler f1 f2 eps xkonechnoe;
y1(1)=1;
y2(1)=1;
x(1)=0;
h = 0.1;
N = xkonechnoe/h;
% m. Eilera-Koshi
disp(' ');
disp('Метод Эйлера Коши априорный выбор шага');

for i=1:N
    x(i+1) = x(i) + h;
    y1_(i+1) = y1(i) + h*f1(x(i),y1(i),y2(i));
    y2_(i+1) = y2(i) + h*f2(x(i),y1(i),y2(i));
    y1(i+1) = y1(i) + (h/2)*(f1(x(i),y1(i),y2(i)) + f1(x(i+1),y1_(i),y2_(i)));
    y2(i+1) = y2(i) + (h/2)*(f2(x(i),y1(i),y2(i)) + f2(x(i+1),y1_(i),y2_(i)));
end

y1_half(1) = 1;
y2_half(1) = 1;
x_half(1) = 0;
N_half = xkonechnoe/(h/2);
for i=1:N_half
    x_half(i+1) = x_half(i) + h/2;
    y1_half(i+1) = y1_half(i) + (h/2)*f1(x_half(i),y1_half(i),y2_half(i));
    y2_half(i+1) = y2_half(i) + (h/2)*f2(x_half(i),y1_half(i),y2_half(i));
end

% Проверка условия на выбор шага и повторный расчет, если условие не выполняется
while max(abs(y1_half(1:2:end)-y1(1:end))) > eps || max(abs(y2_half(1:2:end)-y2(1:end))) > eps
    h = h/2;
    N = xkonechnoe/h;
    for i=1:N
        x(i+1) = x(i) + h;
        y1_(i+1) = y1(i) + h*f1(x(i),y1(i),y2(i));
        y2_(i+1) = y2(i) + h*f2(x(i),y1(i),y2(i));
        y1(i+1) = y1(i) + (h/2)*(f1(x(i),y1(i),y2(i)) + f1(x(i+1),y1_(i),y2_(i)));
        y2(i+1) = y2(i) + (h/2)*(f2(x(i),y1(i),y2(i)) + f2(x(i+1),y1_(i),y2_(i)));
    end
    
    y1_half(1) = 1;
    y2_half(1) = 1;
    x_half(1) = 0;
    N_half = xkonechnoe/(h/2);
    for i=1:N_half
        x_half(i+1) = x_half(i) + h/2;
        y1_half(i+1) = y1_half(i) + (h/2)*f1(x_half(i),y1_half(i),y2_half(i));
        y2_half(i+1) = y2_half(i) + (h/2)*f2(x_half(i),y1_half(i),y2_half(i));
    end
end

% Вывод результатов
disp(['Решение на конечной точке: y1 = ', num2str(y1(end)), ', y2 = ', num2str(y2(end))]);

x_eilkosh = x;
y1_eilkosh = y1;
y2_eilkosh = y2;

clearvars -except x_eiler y1_eiler y2_eiler x_eilkosh y1_eilkosh y2_eilkosh f1 f2 eps xkonechnoe;

y1(1)=1;
y2(1)=1;
x(1)=0;
h = 0.1;
N = xkonechnoe/h;

% m. Runge-Kytta
disp(' ');
disp('Метод Рунге-Кутта априорный выбор шага');

% Метод Рунге-Кутты с шагом h
for i=1:N
    x(i+1) = x(i) + h;
    k1(i) = h*f1(x(i),y1(i),y2(i));
    l1(i) = h*f2(x(i),y1(i),y2(i));
    k2(i) = h*f1(x(i)+h/2,y1(i)+k1(i)/2,y2(i)+l1(i)/2);
    l2(i) = h*f2(x(i)+h/2,y1(i)+k1(i)/2,y2(i)+l1(i)/2);
    k3(i) = h*f1(x(i)+h/2,y1(i)+k2(i)/2,y2(i)+l2(i)/2);
    l3(i) = h*f2(x(i)+h/2,y1(i)+k2(i)/2,y2(i)+l2(i)/2);
    k4(i) = h*f1(x(i+1),y1(i)+k3(i),y2(i)+l3(i));
    l4(i) = h*f2(x(i+1),y1(i)+k3(i),y2(i)+l3(i));
    Dy1(i) = 1/6 * (k1(i) + 2*k2(i) + 2*k3(i) + k4(i));
    Dy2(i) = 1/6 * (l1(i) + 2*l2(i) + 2*l3(i) + l4(i));
    y1(i+1) = y1(i) + Dy1(i);
    y2(i+1) = y2(i) + Dy2(i);
end

% Метод Рунге-Кутты с шагом h/2
y1_half(1) = 1;
y2_half(1) = 1;
x_half(1) = 0;
N_half = xkonechnoe/(h/2);
for i=1:N_half
    x_half(i+1) = x_half(i) + h/2;
    k1_half = (h/2)*f1(x_half(i),y1_half(i),y2_half(i));
    l1_half = (h/2)*f2(x_half(i),y1_half(i),y2_half(i));
    k2_half = (h/2)*f1(x_half(i)+h/4,y1_half(i)+k1_half/2,y2_half(i)+l1_half/2);
    l2_half = (h/2)*f2(x_half(i)+h/4,y1_half(i)+k1_half/2,y2_half(i)+l1_half/2);
    k3_half = (h/2)*f1(x_half(i)+h/4,y1_half(i)+k2_half/2,y2_half(i)+l2_half/2);
    l3_half = (h/2)*f2(x_half(i)+h/4,y1_half(i)+k2_half/2,y2_half(i)+l2_half/2);
    k4_half = (h/2)*f1(x_half(i)+h/2,y1_half(i)+k3_half,y2_half(i)+l3_half);
    l4_half = (h/2)*f2(x_half(i)+h/2,y1_half(i)+k3_half,y2_half(i)+l3_half);
    Dy1_half(i) = 1/6 * (k1_half + 2*k2_half + 2*k3_half + k4_half);
    Dy2_half(i) = 1/6 * (l1_half + 2*l2_half + 2*l3_half + l4_half);
    y1_half(i+1) = y1_half(i) + Dy1_half(i);
    y2_half(i+1) = y2_half(i) + Dy2_half(i);
end

% Проверка условия на выбор шага и повторный расчет, если условие не выполняется
while max(abs(y1_half(1:2:end)-y1(1:end))) > eps || max(abs(y2_half(1:2:end)-y2(1:end))) > eps
    h = h/2;
    N = xkonechnoe/h;
    for i=1:N
        x(i+1) = x(i) + h;
        k1(i) = h*f1(x(i),y1(i),y2(i));
        l1(i) = h*f2(x(i),y1(i),y2(i));
        k2(i) = h*f1(x(i)+h/2,y1(i)+k1(i)/2,y2(i)+l1(i)/2);
        l2(i) = h*f2(x(i)+h/2,y1(i)+k1(i)/2,y2(i)+l1(i)/2);
        k3(i) = h*f1(x(i)+h/2,y1(i)+k2(i)/2,y2(i)+l2(i)/2);
        l3(i) = h*f2(x(i)+h/2,y1(i)+k2(i)/2,y2(i)+l2(i)/2);
        k4(i) = h*f1(x(i+1),y1(i)+k3(i),y2(i)+l3(i));
        l4(i) = h*f2(x(i+1),y1(i)+k3(i),y2(i)+l3(i));
        Dy1(i) = 1/6 * (k1(i) + 2*k2(i) + 2*k3(i) + k4(i));
        Dy2(i) = 1/6 * (l1(i) + 2*l2(i) + 2*l3(i) + l4(i));
        y1(i+1) = y1(i) + Dy1(i);
        y2(i+1) = y2(i) + Dy2(i);
    end
    
    y1_half(1) = 1;
    y2_half(1) = 1;
    x_half(1) = 0;
    N_half = xkonechnoe/(h/2);
    for i=1:N_half
        x_half(i+1) = x_half(i) + h/2;
        k1_half = (h/2)*f1(x_half(i),y1_half(i),y2_half(i));
        l1_half = (h/2)*f2(x_half(i),y1_half(i),y2_half(i));
        k2_half = (h/2)*f1(x_half(i)+h/4,y1_half(i)+k1_half/2,y2_half(i)+l1_half/2);
        l2_half = (h/2)*f2(x_half(i)+h/4,y1_half(i)+k1_half/2,y2_half(i)+l1_half/2);
        k3_half = (h/2)*f1(x_half(i)+h/4,y1_half(i)+k2_half/2,y2_half(i)+l2_half/2);
        l3_half = (h/2)*f2(x_half(i)+h/4,y1_half(i)+k2_half/2,y2_half(i)+l2_half/2);
        k4_half = (h/2)*f1(x_half(i)+h/2,y1_half(i)+k3_half,y2_half(i)+l3_half);
        l4_half = (h/2)*f2(x_half(i)+h/2,y1_half(i)+k3_half,y2_half(i)+l3_half);
        Dy1_half(i) = 1/6 * (k1_half + 2*k2_half + 2*k3_half + k4_half);
        Dy2_half(i) = 1/6 * (l1_half + 2*l2_half + 2*l3_half + l4_half);
        y1_half(i+1) = y1_half(i) + Dy1_half(i);
        y2_half(i+1) = y2_half(i) + Dy2_half(i);
    end
end

% Вывод результатов
disp(['Решение на конечной точке: y1 = ', num2str(y1(end)), ', y2 = ', num2str(y2(end))]);

x_rungekytta = x;
y1_rungekytta = y1;
y2_rungekytta = y2;



% График 1
subplot(2,1,1);
[x_standart,y_standart]=ode45(@standart,[0 1], [1 1]); 
plot(x_standart,y_standart,'oblack');
hold on; 
plot(x_eiler,y1_eiler,'r', 'LineWidth', 4); 
plot(x_eiler,y2_eiler,'r', 'LineWidth', 4);
plot(x_eilkosh,y1_eilkosh,'b', 'LineWidth', 2); 
plot(x_eilkosh,y2_eilkosh,'b', 'LineWidth', 2); 
plot(x_rungekytta,y1_rungekytta,'y--','LineWidth', 1.5); 
plot(x_rungekytta,y2_rungekytta,'y--','LineWidth', 1.5); 

% Вывод результатов
disp(' ');
disp('Встроенный Метод ode45');
disp(['Решение на конечной точке: y1 = ', num2str(y_standart(end,1)), ', y2 = ', num2str(y_standart(end,2))]);

legend('y1 Стандартный оператор','y2 Стандартный оператор','y1 Эйлер','y2 Эйлер','y1 Эйлера-Коши','y2 Эйлера-Коши', 'y1 Рунге-Кутты','y2 Рунге-Кутты', 'Location', 'west');
grid on;


function dy=standart(x,y)
    dy=zeros(2,1);
    dy(1)=y(1)*exp(-x^2) + x*y(2);
    dy(2)=3*x-y(1)+2*y(2);
end