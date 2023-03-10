%%
clc
%------------------- Задание 1 ------------------
A=[6 -1 -1;3 4 4;1 -2 3];
B1=[0;-1;1];
%------------------------------------------------
clc
%Определение детерминанта матрицы коэффициентов
det_A=det(A)
%Определение ранга матрицы коэффициентов
rank_A=rank(A)
%Определение нормы матрицы коэффициентов
norm_A=norm(A)
%Определение числа обусловленности матрицы коэфф.
cond_A=cond(A)
%------------------------------------------------
%Метод обратной матрицы
x=inv(A)*B1;
disp('(Решение полученное методом Обр. Матрицы) x:');
disp(x);
%Решение linsolve
LS=linsolve(A,B1)
%Проверка точности решения
precision=A*x-B1;
disp('проверка точности A*x-B');
disp(precision);
%%
%------------------- Задание 2 ------------------
A=[ 2 -1  0 -3;
    1  0 -1  2;
    3 -2  1 -1;
   -1  3 -1  1];
B=[-9;8;-5;9];
%------------------------------------------------
clc
%Определение детерминанта матрицы коэффициентов
det_A=det(A);
disp('det_A =');
disp(det_A);
%Определение ранга матрицы коэффициентов
rank_A=rank(A);
disp('rank_A =');
disp(rank_A);
%Определение нормы матрицы коэффициентов
norm_A=norm(A);
disp('norm_A =');
disp(norm_A);
%Определение числа обусловленности матрицы коэфф.
cond_A=cond(A);
disp('cond_A =');
disp(cond_A);
%------------------------------------------------
% Метод Гаусса
x=A\B;
disp('(Решение полученное методом Гаусса) x:');
disp(x);
%Решение linsolve
LS=linsolve(A,B)
%Проверка точности решения
precision=A*x-B;
disp('проверка точности A*x-B');
disp(precision);
%%
%------------------- Задание 3 ------------------
A=[2.34 -1.42 -0.54 0.21; 1.44 -0.53 1.43 -1.27;
   0.63 -1.32 -0.65 1.43; 0.56 0.88 -0.67 -2.38];
B=[0.66;-1.44;0.94;0.73];
%------------------------------------------------
clc
%Определение детерминанта матрицы коэффициентов
det_A=det(A);
disp('det_A =');
disp(det_A);
%Определение ранга матрицы коэффициентов
rank_A=rank(A);
disp('rank_A =');
disp(rank_A);
%Определение нормы матрицы коэффициентов
norm_A=norm(A);
disp('norm_A =');
disp(norm_A);
%Определение числа обусловленности матрицы коэфф.
cond_A=cond(A);
disp('cond_A =');
disp(cond_A);
%------------------------------------------------
%Метод LU разложения
[L,U] = lu(A);
y = L\B;
x = U\y;
disp('(Решение полученное методом LU разложения) x:');
disp(x);
%Решение linsolve
LS=linsolve(A,B)
%Проверка точности решения
precision=A*x-B;
disp('проверка точности A*x-B');
disp(precision);
%%
clc
%------------------- Задание 4 ------------------
A=[2 1 3 0 0 0;0 0 3 1 1 0;1 0 3 0 1 0;0 0 1 2 0 0;0 1 2 0 0 0;0 0 1 0 0 1;0 0 6 0 2 1];
A1=[0 0 3 1 1;1 0 3 0 1;0 0 1 2 0;0 1 2 0 0;0 0 1 0 0];%1ая подматрица А
A2=[0 3 1 1 0;0 3 0 1 0;0 1 2 0 0;1 2 0 0 0;0 1 0 0 1];%2ая подматрица А
det_A1=det(A1);%2.000
det_A2=det(A2);%-1

syms b11 b12 b13 b14 b15 b16 b17 b21 b22 b23 b24 b25 b26 b27
%для 1ой подматрицы ----------------------------------------
B1=[1 b12 b13 b14 b15 b16 0;0 b22 b23 b24 b25 b26 1];

    X=B1*A==0;
    vars = [b12 b13 b14 b15 b16 b22 b23 b24 b25 b26];
    vars = solve(X, vars);
    %-------------------------------------------------------
    B1(1,2)= double(vars.b12); B1(2,2)= double(vars.b22);
    B1(1,3)= double(vars.b13); B1(2,3)= double(vars.b23);
    B1(1,4)= double(vars.b14); B1(2,4)= double(vars.b24);
    B1(1,5)= double(vars.b15); B1(2,5)= double(vars.b25);
    B1(1,6)= double(vars.b16); B1(2,6)= double(vars.b26);    
%-----------------------------------------------------------   
%для 2ой подматрицы -------------------------------------------    
B2=[1 0 b13 b14 b15 b16 b17;0 1 b23 b24 b25 b26 b27];

    X=B2*A==0;
    vars = [b13 b14 b15 b16 b17 b23 b24 b25 b26 b27];
    vars = solve(X, vars);
    %-------------------------
    B2(1,3)= double(vars.b13); B2(2,3)= double(vars.b23);
    B2(1,4)= double(vars.b14); B2(2,4)= double(vars.b24);
    B2(1,5)= double(vars.b15); B2(2,5)= double(vars.b25);
    B2(1,6)= double(vars.b16); B2(2,6)= double(vars.b26);
    B2(1,7)= double(vars.b17); B2(2,7)= double(vars.b27);
%----------------------------------------------------------- 
disp('----------ПОЛУЧЕННЫЕ РЕАКЦИИ:----------');
disp('Из B1:');
output_solution(B1); 
disp('Из B2:');
output_solution(B2);
disp('---------------------------------------');
%-----------------------------------------------------------
disp('Числа обусловленности:');
cond_A=cond(A);   disp('cond_A');  disp(cond_A);
cond_A1=cond(A1); disp('cond_A1'); disp(cond_A1);
cond_A2=cond(A2); disp('cond_A2'); disp(cond_A2);
cond_B1=cond(B1); disp('cond_B1'); disp(cond_B1);
cond_B2=cond(B2); disp('cond_B2'); disp(cond_B2);

%Проверка точности решения
precision=B1*A-0; disp('проверка точности B1*A-0='); disp(precision);
precision=B2*A-0; disp('проверка точности B2*A-0='); disp(precision); 

%алгоритм составления и вывода реакций ---------------------
function output_solution(B)
    M=["Na2CO3","HNO3","NaNO3","H2O","CO2","CaO","Ca(NO3)2"];
    sol="";
    for i=1:size(B,1)
        for j=1:size(B,2)
            if B(i,j) < 0
                if sol ~= "" 
                    sol = append(sol, "+");
                end
                sol = append(sol, string(abs(B(i,j))),"*",M(j));
            end
        end
        sol = append(sol, "=");
        flag=0;
        for j=1:size(B,2)
            if B(i,j) > 0
                if flag > 0
                    sol = append(sol, "+");
                end
                flag=1;
                sol = append(sol, string(abs(B(i,j))),"*",M(j));
            end
        end
        disp(sol);
        sol="";
    end
end