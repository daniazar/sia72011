
function [resp] = result (neuronas_por_capa, entrenamiento, respuestas_reales, pesos, eta, beta, type ,x ,y ,z, gen_tole)

% Se ejecutan tantas epocas como sea necesario para obtener el error
% deseado.

[cant_patrones,cols_por_patron] = size(entrenamiento);

resp = zeros(cant_patrones, 1);
if(cols_por_patron ~= neuronas_por_capa(1) + 1)
    disp('Matriz de entrenamiento no valida');    
    return;
end

respuestas = normalize(respuestas_reales,type);
cant_capas = length(neuronas_por_capa);
M = cant_capas;
if(cant_patrones ~= length(respuestas) || neuronas_por_capa(cant_capas) ~= size(respuestas, 2) )
    disp('Matriz esfesrfsfseede respuestas no valida');    
    return;
end

    indexes = randperm(cant_patrones);

    % itero por los patrones de entrenamiento
    for mu=1:cant_patrones
        
        % paso 2 (se elige un patron y se lo aplica a la capa de entrada)
        V = cell(cant_capas, 1);
        h = cell(cant_capas, 1);
        delta = cell(cant_capas, 1);
        V{1} = entrenamiento(indexes(mu),:);
        %h{1} = [];
        %------------------------------------
        % paso 3 (propago por todas las capas)
        for m=2:cant_capas
            neuronas_capa = neuronas_por_capa(m);
            
            V{m} = zeros(1, neuronas_capa + 1);
            h{m} = zeros(1, neuronas_capa + 1);
            delta{m} = zeros(1, neuronas_capa + 1);
            
            V{m}(1) = -1;
                            
            if m == cant_capas                          %Aplicamos la funcion lineal para la ultima capa.
                h{m}(2) = sum(pesos{m}(1,:) .* V{m-1});
                V{m}(2) = beta * h{m}(2);
            else
                for i = 2 : neuronas_capa + 1
                    h{m}(i) = sum(pesos{m}(i-1,:) .* V{m-1});
                    V{m}(i) = g(h{m}(i), beta, type);
                end
            end
        end
       resp(indexes(mu)) = V{M}(2);
            
    end


    
    
error = abs(respuestas - resp);
len = length(error);
cant = 0;

for i=1:len
   if (error(i) < gen_tole)
       cant = cant +1;
   end
end

generalization_rate = (cant/len)*100
    
    
resp = desnormalize(respuestas_reales, resp ,type);


hold off;
%plot3(entrenamiento(:, 2), entrenamiento(:, 3), resp, '.');
hold on;
%preview_input();
%mesh(x, y ,z);

hold off;

% Hasta aca grafica la superposicion de los puntos.

len_respuestas = length(respuestas_reales);

long = length(x) - 1;
hold on;

plot3(entrenamiento(:, 2), entrenamiento(:, 3), resp, '.');
mesh(x, y ,z);
hold off;
   
   
for i=1:len_respuestas

%    resp(i) = respuestas_reales(i) - resp(i);
%    z(entrenamiento(i,2), entrenamiento(i,3)) = z( entrenamiento(i,2), entrenamiento(i,3) ) - resp(i)  ;
end





