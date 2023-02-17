#include <stdio.h>
#include <math.h>

//22.	Постройте график зависимости теплового эффекта реакции C2H4 + H2 = C2H6 
//в диапазоне температур 500 K – 1000 K от температуры с использованием данных БД «Third Millennium…».

double a_ETHYLENE[]={3.95920063E+00, -7.57051373E-03, 5.70989993E-05, -6.91588352E-08, 2.69884190E-11, 5.08977598E+03, 4.09730213E+00};
double a_ETHANE[]={4.29142572E+00,-5.50154901E-03, 5.99438458E-05, -7.08466469E-08, 2.68685836E-11,-1.15222056E+04, 2.66678994E+00};
double a_HYDROGEN[]={0.23443029E+01,0.79804248E-02,-0.19477917E-04,0.20156967E-07,-0.73760289E-11,-0.91792413E+03,0.68300218E+00};
double R = 8.314;

double calc(double T, double a[]);

int main(){
    double ETHYLENE, HYDROGEN, ETHANE = 0;
    for(double t = 500; t <= 1000; t+=10){
        ETHYLENE = calc(t, a_ETHYLENE);//реагент
        ETHANE = calc(t, a_ETHANE);//продукт
        HYDROGEN = calc(t, a_HYDROGEN);//реагент
        //printf("T=%.2lf ETHANE %-10.6lf\n", t, ETHANE);
        //printf("T=%.2lf ETHYLENE %-10.6lf\n", t, ETHYLENE);
        //printf("T=%.2lf HYDROGEN %-10.6lf\n", t, HYDROGEN);
        printf("%.0lf %-10.6lf\n", t, ETHANE-(ETHYLENE+HYDROGEN));
    }
    return 0;
}

double calc(double T, double a[]) {
    double h0 = R*(a[0] * T + a[1]/2 * powl(T, 2) + 
                    a[2]/3 * powl(T, 3) + 
                    a[3]/4 * powl(T, 4) + 
                    a[4]/5 * powl(T, 5) + 
                    a[5]);
    return h0;
}