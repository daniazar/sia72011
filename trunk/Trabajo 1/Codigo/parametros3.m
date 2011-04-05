function [entrenamiento, respuestas, pesos, delta_pesos_anterior] = parametros3 (interval, neuronas_por_capa)

% Se puede alterar el valor de la semilla para generar distintos valores de pesos.

rand('seed', 1301132);

x = -3:interval:3;
y = -3:interval:3;

m1 = length(x);
m2 = length(y);

cte = 3;

count = 0;
for i=1:m1
    for j=1:m2
        if( (x(i)+0.6)^2 + (y(j)+1)^2 < (1.5)^2)
            if (rand<0.09)
                count = count+1;
                entrenamiento(count,1) = -1;
                entrenamiento(count,2) = x(i);
                entrenamiento(count,3) = y(j);
                respuestas(count) = cte*((1-x(i))^2)*exp(-x(i)^2-(y(j)+1)^2);
            end
        else
            if (rand<0.02)
                count = count+1;
                entrenamiento(count,1) = -1;
                entrenamiento(count,2) = x(i);
                entrenamiento(count,3) = y(j);
                respuestas(count) = cte*((1-x(i))^2)*exp(-x(i)^2-(y(j)+1)^2);
            end
            
        end 
    end
end

respuestas = respuestas';

% plot3(entrenamiento(:, 2), entrenamiento(:, 3), respuestas, '.');

cantn = length(neuronas_por_capa);
pesos = cell(cantn, 1);
delta_pesos_anterior = cell(cantn, 1);

pesos{1} = [];

for i = 2 : cantn 
    pesos{i} = rand(neuronas_por_capa(i),neuronas_por_capa(i - 1)+1)-0.5;
    delta_pesos_anterior{i} = zeros(neuronas_por_capa(i),neuronas_por_capa(i - 1)+1);
end;