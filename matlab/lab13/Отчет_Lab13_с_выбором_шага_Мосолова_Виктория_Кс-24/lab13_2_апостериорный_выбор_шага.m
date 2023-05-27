clearvars;
% 2 zadanie
f1 = @(x,y1,y2) y1.*exp(x.^2) + x.*y2;
f2 = @(x,y1,y2) 3.*x-y1+2.*y2;
y1(1)=1;
y2(1)=1;
x(1)=0;
h = 0.1;

% 2 zadanie
xkonechnoe = 1;
N = xkonechnoe/h;
eps = 0.001;
disp(' ');
disp('Задание 2');
disp('Начальный шаг h=0.1, точность eps=0.001');
disp(' ');

% m. Eilera
disp('Метод Эйлера апостериорный выбор шага');
while x(end) <= xkonechnoe
    % Вычисление решения с шагом h
    y1_h1 = y1(end) + h * f1(x(end), y1(end), y2(end));
    y2_h1 = y2(end) + h * f2(x(end), y1(end), y2(end));
    
    % Вычисление решения с шагом h/2
    y1_h2 = y1(end) + (h/2) * f1(x(end), y1(end), y2(end));
    y2_h2 = y2(end) + (h/2) * f2(x(end), y1(end), y2(end));
    
    % Апостериорный выбор шага
    if abs(y1_h1 - y1_h2) <= eps
        % Удвоение шага
        x(end+1) = x(end) + h;
        y1(end+1) = y1_h1;
        y2(end+1) = y2_h1;
        h = h * 2;
    else
        % Сокращение шага вдвое
        h = h / 2;
        continue;
    end
end

% Вывод результатов
disp(['Решение на конечной точке: y1 = ', num2str(y1(end)), ', y2 = ', num2str(y2(end))]);
x_eiler = x;
y1_eiler = y1;
y2_eiler = y2;

clearvars -except x_eiler y1_eiler y2_eiler f1 f2 eps;
y1(1)=1;
y2(1)=1;
x(1)=0;
h = 0.1;
xkonechnoe = 1;
N = xkonechnoe/h;
% m. Eilera neyavniy
disp(' ');
disp('Неявный Метод Эйлера апостериорный выбор шага');

% Итеративный выбор шага
while x(end) < xkonechnoe
    y1_new = y1(end);
    y2_new = y2(end);
    x_new = x(end);
    for i = 1:N
        y1_old = y1_new;
        y2_old = y2_new;
        x_old = x_new;
        y1_new = y1_old + h * f1(x_old+h, y1_old, y2_old);
        y2_new = y2_old + h * f2(x_old+h, y1_old, y2_old);
        x_new = x_old + h;
    end
    y_h = y1_new;
    
    y1_new = y1(end);
    y2_new = y2(end);
    x_new = x(end);
    for i = 1:N/2
        y1_old = y1_new;
        y2_old = y2_new;
        x_old = x_new;
        y1_new = y1_old + h/2 * f1(x_old+h/2, y1_old, y2_old);
        y2_new = y2_old + h/2 * f2(x_old+h/2, y1_old, y2_old);
        x_new = x_old + h/2;
    end
    y_h2 = y1_new;
    
    % Вычисляем погрешность и выбираем новый шаг
    err = abs(y_h - y_h2);
    if err <= eps
        % Увеличиваем шаг
        h = min(2*h, xkonechnoe - x(end));
        y1(end+1) = y_h;
        y2(end+1) = y2_new;
        x(end+1) = x(end) + h;
    else
        % Уменьшаем шаг
        h = h/2;
    end
end

% Результаты
disp(['Решение на конечной точке: y1 = ', num2str(y1(end)), ', y2 = ', num2str(y2(end))]);

y1_neyavEILER = y1;
y2_neyavEILER = y2;

% График 2
subplot(2,1,2);
[x_standart,y_standart]=ode45(@standart,[0 1], [1 1]); 
disp(' ');
disp('Встроенный Метод ode45');
disp(['Решение на конечной точке: y1 = ', num2str(y_standart(end,1)), ', y2 = ', num2str(y_standart(end,2))]);

plot(x_standart,y_standart,'oblack');
hold on; 
plot(x_eiler,y1_eiler,'r--', 'LineWidth', 3); 
plot(x_eiler,y2_eiler,'r', 'LineWidth', 3);
plot(x,y1_neyavEILER,'b--', 'LineWidth', 2); 
plot(x,y2_neyavEILER,'b', 'LineWidth', 2); 
legend('y1 Стандартный оператор','y2 Стандартный оператор','y1 Эйлер (Явный)','y2 Эйлер (Явный)','y1 Эйлер (Неявный)','y2 Эйлер (Неявный)', 'Location', 'west');
grid on;


function dy=standart(x,y)
    dy=zeros(2,1);
    dy(1)=y(1)*exp(-x^2) + x*y(2);
    dy(2)=3*x-y(1)+2*y(2);
end