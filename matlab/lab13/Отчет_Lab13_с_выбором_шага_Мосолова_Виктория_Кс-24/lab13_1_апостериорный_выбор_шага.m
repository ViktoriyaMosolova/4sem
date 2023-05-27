clc
clear
%Реализовать апостериорную или априорную стратегию выбора шага интегрирования.
disp('Задание 1');
f1 = @(x,y1,y2) y1.*exp(-x.^2) + x.*y2;
f2 = @(x,y1,y2) 3.*x-y1+2.*y2;

y1_h(1)=1;
y2_h(1)=1;
x(1)=0;

h = 0.1;
eps=0.001;
disp('Начальный шаг h=0.1, точность eps=0.001');
disp(' ');

% m. Eilera
disp('Метод Эйлера апостериорный выбор шага');
while x(end) <= 1
    y1_h1 = y1_h(end) + h * f1(x(end), y1_h(end), y2_h(end));
    y2_h1 = y2_h(end) + h * f2(x(end), y1_h(end), y2_h(end));
    
    y1_h2 = y1_h(end) + (h/2) * f1(x(end), y1_h(end), y2_h(end));
    y2_h2 = y2_h(end) + (h/2) * f2(x(end), y1_h(end), y2_h(end));
    
    if abs(y1_h1 - y1_h2) <= eps
        x(end+1) = x(end) + h;
        y1_h(end+1) = y1_h1;
        y2_h(end+1) = y2_h1;
        h = h * 2;
    else
        h = h / 2;
        continue;
    end
end

% Вывод результатов
disp(['Решение на конечной точке: y1 = ', num2str(y1_h(end)), ', y2 = ', num2str(y2_h(end))]);
x_eiler = x;
y1_eiler = y1_h;
y2_eiler = y2_h;

clearvars -except x_eiler y1_eiler y2_eiler f1 f2 eps;
y1_h(1)=1;
y2_h(1)=1;
y1_h1(1)=1;
y2_h1(1)=1;
y1_h2(1)=1;
y2_h2(1)=1;
x(1)=0;
h = 0.1;
% m. Eilera-Koshi
disp(' ');
disp('Метод Эйлера Коши апостериорный выбор шага');
while x(end) <= 1
    y1_ = y1_h(end) + h*f1(x(end), y1_h(end), y2_h(end));
    y2_ = y2_h(end) + h*f2(x(end), y1_h(end), y2_h(end));
    y1_h1 = y1_h(end) + (h/2)*(f1(x(end), y1_h(end), y2_h(end)) + f1(x(end)+h,y1_,y2_));
    y2_h1 = y2_h(end) + (h/2)*(f2(x(end), y1_h(end), y2_h(end)) + f2(x(end)+h,y1_,y2_));
        
    y1_ = y1_h(end) + (h/2)*f1(x(end), y1_h(end), y2_h(end));
    y2_ = y2_h(end) + (h/2)*f2(x(end), y1_h(end), y2_h(end));
    y1_h2 = y1_h(end) + ((h/2)/2)*(f1(x(end), y1_h(end), y2_h(end)) + f1(x(end)+h/2,y1_,y2_));
    y2_h2 = y2_h(end) + ((h/2)/2)*(f2(x(end), y1_h(end), y2_h(end)) + f2(x(end)+h/2,y1_,y2_));
    
    if abs(y1_h1 - y1_h2) <= eps
        x(end+1) = x(end) + h;
        y1_h(end+1) = y1_h1;
        y2_h(end+1) = y2_h1;
        h = h * 2;
    else
        h = h / 2;
        continue;
    end

end

% Вывод результатов
disp(['Решение на конечной точке: y1 = ', num2str(y1_h(end)), ', y2 = ', num2str(y2_h(end))]);

x_eilkosh = x;
y1_eilkosh = y1_h;
y2_eilkosh = y2_h;

clearvars -except x_eiler y1_eiler y2_eiler x_eilkosh y1_eilkosh y2_eilkosh f1 f2 eps;

y1_h(1)=1;
y2_h(1)=1;
y1_h1(1)=1;
y2_h1(1)=1;
y1_h2(1)=1;
y2_h2(1)=1;
x(1)=0;
h = 0.1;
% m. Runge-Kytta
disp(' ');
disp('Метод Рунге-Кутта апостериорный выбор шага');
while x(end) <= 1
    % Вычисление решения с шагом h
    k1 = h*f1(x(end), y1_h(end), y2_h(end));
    l1 = h*f2(x(end), y1_h(end), y2_h(end));
    
    k2 = h*f1(x(end)+h/2,y1_h(end)+k1/2,y2_h(end)+l1/2);
    l2 = h*f2(x(end)+h/2,y1_h(end)+k1/2,y2_h(end)+l1/2);
    
    k3 = h*f1(x(end)+h/2,y1_h(end)+k2/2,y2_h(end)+l2/2);
    l3 = h*f2(x(end)+h/2,y1_h(end)+k2/2,y2_h(end)+l2/2);
    
    k4 = h*f1(x(end)+h,y1_h(end)+k3,y2_h(end)+l3);
    l4 = h*f2(x(end)+h,y1_h(end)+k3,y2_h(end)+l3);
    
    Dy1 = 1/6 * (k1 + 2*k2 + 2*k3 + k4);
    Dy2 = 1/6 * (l1 + 2*l2 + 2*l3 + l4);
    
    y1_h1 = y1_h(end) + Dy1;
    y2_h1 = y2_h(end) + Dy2;
    
    % Вычисление решения с шагом h/2
    k1 = h/2*f1(x(end), y1_h(end), y2_h(end));
    l1 = h/2*f2(x(end), y1_h(end), y2_h(end));
    
    k2 = h/2*f1(x(end)+h/4,y1_h(end)+k1/2,y2_h(end)+l1/2);
    l2 = h/2*f2(x(end)+h/4,y1_h(end)+k1/2,y2_h(end)+l1/2);
    
    k3 = h/2*f1(x(end)+h/4,y1_h(end)+k2/2,y2_h(end)+l2/2);
    l3 = h/2*f2(x(end)+h/4,y1_h(end)+k2/2,y2_h(end)+l2/2);
    
    k4 = h/2*f1(x(end)+h/2,y1_h(end)+k3,y2_h(end)+l3);
    l4 = h/2*f2(x(end)+h/2,y1_h(end)+k3,y2_h(end)+l3);
    
    Dy1 = 1/6 * (k1 + 2*k2 + 2*k3 + k4);
    Dy2 = 1/6 * (l1 + 2*l2 + 2*l3 + l4);
    
    y1_h2 = y1_h(end) + Dy1;
    y2_h2 = y2_h(end) + Dy2;
        
    % Апостериорный выбор шага
    if abs(y1_h1 - y1_h2) <= eps
        % Удвоение шага
        x(end+1) = x(end) + h;
        y1_h(end+1) = y1_h1;
        y2_h(end+1) = y2_h1;
        h = h * 2;
    else
        % Сокращение шага вдвое
        h = h / 2;
        continue;
    end
    
end

x_rungekytta = x;
y1_rungekytta = y1_h;
y2_rungekytta = y2_h;

% Вывод результатов
disp(['Решение на конечной точке: y1 = ', num2str(y1_h(end)), ', y2 = ', num2str(y2_h(end))]);

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