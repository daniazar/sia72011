function [entrenamiento, respuestas, pesos] = parametros (neuronas_por_capa)

% Se puede alterar el valor de la semilla para generar distintos valores de pesos.
rand('seed', 131);

N = neuronas_por_capa(1);
fils = 2^N;
cols = N;
entrenamiento = ones (fils, cols+1);

% Se genera la tabla de verdad para la compuerta XOR

for j = 1 : cols
  value = -1;
  for i = 1 : fils
      if (mod(i-1,2^(j-1)) == 0)
          value = value*-1;
      end
      entrenamiento(i, j+1) = value;
   end; 
end;

for i = 1 : fils
    entrenamiento(i, 1) = -1; 
end;

respuestas = ones(fils, 1);

for i = 1 : fils
    cant = 0;
    for j = 2 : cols +1
        if(entrenamiento(i,j) == 1)
            cant = cant+1;  
        end;
    end;
  if(cant == 1)
      respuestas(i) = 1;
  else
      respuestas(i) = -1;      
  end;
  
end;

cantn = length(neuronas_por_capa);
pesos = cell(cantn, 1);

pesos{1} = [];

for i = 2 : cantn 
    pesos{i} = rand(neuronas_por_capa(i),neuronas_por_capa(i - 1)+1)-0.5;
end;