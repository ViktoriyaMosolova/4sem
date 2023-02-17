x=-4:0.1:4;
y=x.^3-x;
plot(x, y)

A=[2,1,3,0,0,0;0,0,3,1,1,0;1,0,3,0,1,0;0,0,1,2,0,0;0,1,2,0,0,0;0,0,1,0,0,1;0,0,6,0,2,1];
r = rank(A);
L = zeros(r);
for x=0:2
    for y=0:1
        for i=x+1:r+x
            for j=y+1:r+y
                L(i-x,j-y)=A(i,j);
            end
        end
        if det(L)~=0
        disp(L);
        end
    end
end