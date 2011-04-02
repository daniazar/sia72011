function preview_input ()

x = -2:0.1:1;
y = -1:0.1:2;

[n m] = size(x);

for i=1:m
    for j=1:m
        z(i,j) = 3*((1-x(i))^2)*exp(-x(i)^2-(y(j)-1)^2);
    end
end

mesh (x,y,z);

end