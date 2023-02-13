#include <stdio.h>
#include <math.h>

//22.	Постройте график зависимости теплового эффекта реакции C2H4 + H2 = C2H6 
//в диапазоне температур 500 K – 1000 K от температуры с использованием данных БД «Third Millennium…».

double a_sub[]={1.25245480E+01,-1.01018826E-02, 2.21992610E-04,-2.84863722E-07, 1.12410138E-10,-2.98434398E+04,-1.97109989E+01};
double R = 8.314;

double calc(double T, double a[]);

int main(){
    double sub = 0;
    for(double t = 298; t <= 1000; t+=10){
        sub = calc(t, a_sub);
        printf("%.0lf %-10.6lf\n", t, sub);
    }
    double real_sub_c=239.74;
    double abs=fabs(calc(400, a_sub)-real_sub_c);
    double rel=abs/real_sub_c*100;
    printf("T=400K abs=%.2lf rel=%.2lf%%\n", abs, rel);
    return 0;
}

double calc(double T, double a[]) {
    double c0 = R*( a[0] + 
                    a[1] * T + 
                    a[2] * powl(T, 2) + 
                    a[3] * powl(T, 3) + 
                    a[4] * powl(T, 4));
    return c0;
}