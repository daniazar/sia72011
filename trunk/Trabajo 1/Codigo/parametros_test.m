function [entrenamiento, respuestas, pesos, delta_pesos_anterior] = parametros_test (interval, neuronas_por_capa)

% Se puede alterar el valor de la semilla para generar distintos valores de pesos.
rand('seed', 131);

x = -3:interval:3;

m1 = length(x);

count = 0;
for i=1:m1
    count = count+1;
    entrenamiento(count,1) = -1;
    entrenamiento(count,2) = x(i);
    respuestas(count) = exp(x(i)) / 25;
end

respuestas = respuestas';

cantn = length(neuronas_por_capa);
pesos = cell(cantn, 1);
delta_pesos_anterior = cell(cantn, 1);

pesos{1} = [];

for i = 2 : cantn 
    pesos{i} = rand(neuronas_por_capa(i),neuronas_por_capa(i - 1)+1)-0.5;
    delta_pesos_anterior{i} = zeros(neuronas_por_capa(i),neuronas_por_capa(i - 1)+1);
end;

plot(entrenamiento(:, 2), respuestas);