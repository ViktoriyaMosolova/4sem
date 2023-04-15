x = [3 -2 -1 0 1 2 3];
y = [-0.71 -0.01 0.51 0.82 0.88 0.51 0.49];
f = polyfit(x, y, 3);

df = polyder(f);
dy_v = polyval(df, -1.5);
disp('первая производная');
num2str(dy_v)

d2f = polyder(df);
d2y_v = polyval(d2f, -1.5);
disp('вторая производная');
num2str(d2y_v)




