#include <stdio.h>
#include <math.h>

//Рассчитайте с помощью полиномов NASA энтропию при 250 K для вещества C3H2Br2

double a_C3H2Br2[]={2.81962796E+00, 3.36504926E-02, -3.62801358E-05, 1.96202684E-08, -3.98079099E-12, 2.80295999E+04, 1.63398525E+01};
double R = 8.314;

double calc(double T, double a[]);
double dS(double V1, double V2);

int main(){
    //задание 1------------------------------
    double t = 250;
    printf("1) C3H2Br2\nS=%-10.6lf\n\n", calc(t, a_C3H2Br2));
    //задание 2------------------------------
    double V1 = 2*pow(10, -4), V2 = 7*pow(10, -4);
    printf("2) Kr+CO V1=2*10^4 V2=7*10^4\ndS=%-10.6lf\n", dS(V1, V2));
    return 0;
}

double calc(double T, double a[]) {
    double s0 = R*(a[0] * log(T) + 
                    a[1] * T + 
                    a[2]/2 * powl(T, 2) + 
                    a[3]/3 * powl(T, 3) + 
                    a[4]/4 * powl(T, 4) + 
                    a[6]);
    return s0;
}


double dS(double V1, double V2){
    double n1,n2, p, t1, t2=0;
    p=1.01*pow(10,5);
    t1=t2=298;
    n1 = (p * V1) / (R * t1);
    n2 = (p * V2) / (R * t2);
    return n1*R*log((V1+V2)/V1)+n2*R*log((V1+V2)/V2);
}
