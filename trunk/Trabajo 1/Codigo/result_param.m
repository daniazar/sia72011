function [x y z entrenamiento respuestas] = result_param ()

x = -3:0.1:3;
y = -3:0.1:3;

[n m] = size(x);
count = 0;

entrenamiento = zeros(m*m, 3);
respuestas = zeros(m*m - 10, 1);
z = zeros(m);

for i=1:m
    for j=1:m
        count = count +1;
        z(j,i) = 3*( (1-x(i))^2 )*exp(- x(i)^2 - (y(j)+1)^2 );
        entrenamiento(count,1) = -1;
        entrenamiento(count,2) = x(i);
        entrenamiento(count,3) = y(j);
        respuestas(count) = z(j,i);

    end
end
% respuestas = respuestas';
