%исходная матрица ------------------------
A=[2,1,3,0,0,0;
   0,0,3,1,1,0;
   1,0,3,0,1,0;
   0,0,1,2,0,0;
   0,1,2,0,0,0;
   0,0,1,0,0,1;
   0,0,6,0,2,1];
%ранг исходной матрицы -------------------
r = rank(A);
matrix_del_strok = A;
%set(0);
func_strok_stolb(A, r, matrix_del_strok);
%disp(c)

%function set(val)
%global c
%c = val;
%end

%function x = get()
%global c
%x = c;
%end

 function func_strok_stolb(A, r, matrix_del_strok)
     if size(matrix_del_strok,1) == r
            func_stolb(A, r, matrix_del_strok);
     end
     for i = 1:size(A,1)
        matrix_del_strok = A;
        if size(matrix_del_strok,1) > r
            matrix_del_strok(i, :) = [];
            matrix_del_strok2 = matrix_del_strok;
            func_strok_stolb(matrix_del_strok, r, matrix_del_strok2);
        end
     end
 end
 
 function func_stolb(matrix_del_strok, r, matrix_del_stolb)
    if size(matrix_del_stolb,2) == r
           func_determ(matrix_del_stolb, r);
    end
    for k = 1:size(matrix_del_strok,2)
        matrix_del_stolb = matrix_del_strok;
        if size(matrix_del_stolb,2) > r
            matrix_del_stolb(:, k) = [];
            matrix_del_stolb2 = matrix_del_stolb;
            func_stolb(matrix_del_stolb, r, matrix_del_stolb2);
        end
    end
 end
 
 function func_determ(matrix, r)
     if size(matrix,1) == r && size(matrix,2) == r
         if abs(det(matrix))> 0.001
            disp(matrix);
            %c = get();
            %set(c+1);
         end
     end
 end