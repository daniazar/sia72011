function [pesos, epocas, resp] = red (neuronas_por_capa, entrenamiento, respuestas_reales, pesos, delta_pesos_anterior, tolerancia, eta, beta, alfa, type,learn_tole )

% Se ejecutan tantas epocas como sea necesario para obtener el error
% deseado.

[cant_patrones,cols_por_patron] = size(entrenamiento);

err_patron = zeros(cant_patrones, 1);
resp = zeros(cant_patrones, 1);
globalerror = bitmax;
epocas = 0;
eta_counter = 0;
if(cols_por_patron ~= neuronas_por_capa(1) + 1)
    disp('Matriz de entrenamiento no valida');    
    return;
end

respuestas = normalize(respuestas_reales,type);
cant_capas = length(neuronas_por_capa);

if(cant_patrones ~= length(respuestas) || neuronas_por_capa(cant_capas) ~= size(respuestas, 2) )
    disp('Matriz de respuestas no valida');    
    return;
end

while (globalerror > tolerancia)

    epocas = epocas+1
    indexes = randperm(cant_patrones);
    ultimos_pesos = pesos;
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
        
        % paso 4 (se calculan los delta para la capa de salida)
        M = cant_capas;
        aux = respuestas(indexes(mu)) - V{M}(2);        % por que hay un -1s
%        delta{M}(2) = g_prima(h{M}(2), beta, type) * aux;
        delta{M}(2) = beta * aux;
        
        
        % paso 5 (se propagan hacia atras los deltas)
        for m = M-1:-1:2
            neuronas_capa = neuronas_por_capa(m);
            neu_capa_anterior = neuronas_por_capa(m+1);
            for i = 2 : neuronas_capa + 1
                acum = 0;
                for j = 2 : neu_capa_anterior + 1
                    acum = acum + pesos{m+1}(j-1,i) * delta{m+1}(j);    %atencion, el cambio de incide!
                end
                delta{m}(i) = g_prima(h{m}(i), beta, type) * acum;
            end
        end
        
        % paso 6 (se actualizan los pesos para todas las capas)
        for m=2:cant_capas
            neuronas_capa = neuronas_por_capa(m);
            neuronas_capa_anterior = neuronas_por_capa(m-1);
            for i=2:neuronas_capa + 1
                for j=1:neuronas_capa_anterior + 1
%                    disp(['i: ' num2str(i) ' j: ' num2str(j) ' m: ' num2str(m)])
                    aux_delta = eta * delta{m}(i) * V{m-1}(j);
                    delta_pesos = aux_delta + alfa * delta_pesos_anterior{m}(i-1, j);   % Momentum
                    pesos{m}(i -1, j) = pesos{m}(i -1, j) + delta_pesos;
                    delta_pesos_anterior{m}(i -1, j) = aux_delta;
                end
            end
        end
        %------------------------------------

        err_patron(indexes(mu)) = (respuestas(indexes(mu)) - V{M}(2))^2;
        resp(indexes(mu)) = V{M}(2);
            
    end
        

    % calculo el valor del error global

    last_error = globalerror;
    globalerror = sum(err_patron)/2;
    delta_error = globalerror - last_error;

    % Constante que incrementa el Learning Rate: 0.3
    % Constante que decrementa el Learning Rate: 0.95
    min_eta = globalerror / 100;
        ultimos_pesos = pesos;

    if( delta_error > min_eta)
        eta_counter = 0;
        eta = eta * 0.95;
    else
        pesos = ultimos_pesos;
        global_error = last_error; 
        eta_counter = eta_counter +1;
        if(eta_counter >= 2)
            eta_counter = 0;
            eta = eta * 1.10;
        end
    end
    
   % if(eta < 0.03)
    %    eta = 0.48;
   % end
   eta;
   globalerror
end


error = abs(respuestas - resp);
len = length(error);
cant = 0;

for i=1:len
   if (error(i) < learn_tole)
       cant = cant + 1;
   end
end

learn_rate = (cant/len)*100

resp = desnormalize(respuestas_reales, resp ,type);


%   hold off;
%   plot3(entrenamiento(:, 2), entrenamiento(:, 3), resp, '.');
%   hold on;
%   plot3(entrenamiento(:, 2), entrenamiento(:, 3), respuestas_reales, 'r.');
%   hold off;
