%Задание 1
%Дано----------------------------------------------------------------
x=2.5378;
y=2.536;
%абс. погр
p_abs_x=0.0001;
p_abs_y=0.001;
%отн. погр
p_rel_x=3.94e-05;
p_rel_y=3.94e-04;
%--------------------------------------------------------------------
%Найти предельные абс. и отн. погрешности суммы и разности этих чисел
%--------------------------------------------------------------------
%Решение:
sum=x+y;
sub=x-y;
disp('sum');
disp(sum);
disp('sub');
disp(sub);
%Предельные абс. погрешности
pr_abs_sum=p_abs_x+p_abs_y;
pr_abs_sub=p_abs_x-p_abs_y;
disp('предельная абсолютная погрешность суммы');
disp(pr_abs_sum);
disp('предельная абсолютная погрешность разности');
disp(pr_abs_sub);
%Предельные отн. погрешности
p_rel_sum=(x*p_rel_x+y*p_rel_y)/(x+y);
p_rel_sub=(p_abs_x+p_abs_y)/abs(x-y);
disp(p_rel_sum);
disp(p_rel_sub);

%Задание 2
x=37.1;
y=9.87;
z=6.052;
delx=0.1;
dely=0.05;
delz=0.02;
%Предельные относ. погрешности переменных
dx=delx/x;
dy=dely/y;
dz=delz/z;
disp(dx);
disp(dy);
disp(dz);
%Предельная относ.погрешность функции
pfunc=2*dx+2*dy+1/4*dz;
disp(pfunc);
