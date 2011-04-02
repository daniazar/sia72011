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
function [pesos, epocas, resp] = red (neuronas_por_capa, entrenamiento, respuestas, pesos, tolerancia, eta, beta)

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
eta_counter = 0;
last_error = globalerror;
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
        for m = M-1:-1:2
            neuronas_capa = neuronas_por_capa(m);
            neu_capa_anterior = neuronas_por_capa(m+1);
            for i = 2 : neuronas_capa + 1
                acum = 0;
                for j = 2 : neu_capa_anterior + 1
                    acum = acum + pesos{m+1}(j-1,i) * delta{m+1}(j);    %atencion, el cambio de incide!
                end
                delta{m}(i) = g_prima(h{m}(i), beta) * acum;
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
            resp(indexes(mu)) = V{M}(2);
            
    end
    % calculo el valor del error global
    last_error = globalerror;
    globalerror = sum(err_patron)/2
    
    delta_error = globalerror - last_error;
            if( delta_error >= 0)
                eta_counter = 0;
                eta = eta -0.01 * eta;
            else
                eta_counter = eta_counter +1;
                if(eta_counter > 10)
                    eta = eta +0.01;
                end
            end
            
end

    hold off
    plot(entrenamiento(:, 2), resp)
    hold on
    plot(entrenamiento(:, 2), respuestas)






