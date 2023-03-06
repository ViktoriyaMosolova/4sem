#include <stdio.h>
#include <math.h>

//Рассчитайте с помощью полиномов NASA энтропию при 250 K для вещества C3H2Br2

double a_C3H2Br2[]={2.81962796E+00, 3.36504926E-02, -3.62801358E-05, 1.96202684E-08, -3.98079099E-12, 2.80295999E+04, 1.63398525E+01};
//double a_O2[]={3.78245636E+00, -2.99673415E-03, 9.84730200E-06, -9.68129508E-09, 3.24372836E-12, -1.06394356E+03, 3.65767573E+00};
double R = 8.314;

double calc(double T, double a[]);
double dS(double V1, double V2);

int main(){
    //задание 1----------------------------------------
    double t = 250;
    printf("%-10.6lf\n", calc(t, a_C3H2Br2));
    //задание 2----------------------------------------
    double V1 = 1, V2 = 2;
    printf("%-10.6lf\n", dS(V1, V2));
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
    double n1,n2, x1,x2=0;
    n1=x1=V1/(V1+V2);
    n2=x2=V2/(V1+V2);
    return -(n1+n2)*R*(x1*log(x1)+x2*log(x2));
}
