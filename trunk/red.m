%   Funcion que calcula los pesos para una red neuronal multicapa
%
%   Parametros de entrada
%   ---------------------
%  $     - neuronas_por_capa:    vector de N componentes cuyo 
%       elemento i corresponde a la cantidad de neuronas de esa 
%       capa. NO incluir la neurona correspondiente al umbral.
%
%  $     - entrenamiento:        matriz de 'mu' filas por
%       'neuronas_por_capa(1)' + 1 columnas (la primera corresponde a los
%       umbrales y vale '-1').
%       
%       - respuestas:           matriz de 'mu' filas y 'neuronas_por_capa(M)'
%       columnas, con 'M' valiendo la cantidad de capas.
%
%       - pesos:                cell array de N - 1, cuyo elemento i
%       corresponde a una matriz de 'neuronas_por_capa(i+1)' + 1 filas por
%       'neuronas_por_capa(i)' + 1 columnas.
%
%   Parametros de salida
%   --------------------
%       - pesos:                cell array con los pesos modificados
%       siguiendo una actualizacion INCREMENTAL, para los patrones de
%       entrenamiento y la tolerancia dados.
%
%       - epocas:               cantidad de epocas que le tomo al algoritmo
%       encontrar los pesos para la tolerancia definida.
%
%
function [pesos, epocas] = red (neuronas_por_capa, entrenamiento, respuestas, pesos, tolerancia, eta, beta)

globalerror = bitmax;
epocas = 0;

% Se ejecutan tantas epocas como sea necesario para obtener el error
% deseado.

[cant_patrones,cols_por_patron] = size(entrenamiento);
if(cols_por_patron ~= neuronas_por_capa(1) + 1)
    disp('Matriz de entrenamiento no valida');    
    return;
end
cant_capas = length(neuronas_por_capa);
if(cant_patrones ~= length(respuestas) || neuronas_por_capa(cant_capas) ~= size(respuestas, 2) )
    disp('Matriz de respuestas no valida');    
    return;
end
err_patron = [];

while (globalerror > tolerancia)
    epocas = epocas+1;
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
          %  h{m}(1) = -1;   % Clave! (Cuanto debe valer esto???)
            for i = 2 : neuronas_capa + 1
                h{m}(i) = sum(pesos{m}(i-1,:) .* V{m-1});
                V{m}(i) = g(h{m}(i), beta);
            end
        end
        
        % paso 4 (se calculan los delta para la capa de salida)
        M = cant_capas;
        aux = respuestas(indexes(mu)) - V{M}(2);% por que hay un -1
        delta{M}(2) = g_prima( h{M}(2), beta ) * aux;

        % paso 5 (se propagan hacia atras los deltas)
        for m = M:-1:2
            neuronas_capa = neuronas_por_capa(m-1);
            neu_capa_ant = neuronas_por_capa(m);
            for i = 1 : neuronas_capa + 1               
                acum = 0;
                for j = 2 : neu_capa_ant + 1
                    acum = acum + pesos{m}(i,j) * delta{m}(j);
                end
               
                delta{m-1}(i) = g_prima(h{m-1}(i), beta) * acum;
            end
        end
        
        % paso 6 (se actualizan los pesos para todas las capas)
        for m=2:cant_capas
            neuronas_capa = neuronas_por_capa(m);
            neuronas_capa_anterior = neuronas_por_capa(m-1);
            for i=2:neuronas_capa + 1
                for j=1:neuronas_capa_anterior + 1
%                    disp(['i: ' num2str(i) ' j: ' num2str(j) ' m: ' num2str(m)])
                    delta_pesos = eta * delta{m}(i) * V{m-1}(j);
                    pesos{m}(i -1, j) = pesos{m}(i -1, j) + delta_pesos; % en esto hay duda
                end
            end
        end
        %------------------------------------

            err_patron(indexes(mu)) = (respuestas(indexes(mu)) - V{M}(2))^2;
    end
    % calculo el valor del error global
    globalerror = sum(err_patron)/2
end







