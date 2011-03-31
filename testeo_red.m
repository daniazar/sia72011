function [out] = testeo_red (entrada, neuronas_por_capa, pesos, tolerancia, eta, beta)

% La entrada es un vector cuya cantidad de componentes es igual a la cantidad de neuronas en la capa 1.

cant_capas = size(neuronas_por_capa, 2);
        
% se aplica a la capa de entrada el vector 'entrada'
V{1} = entrada;
h = {};
% propago por todas las capas
        for m=2:cant_capas
            neuronas_capa = neuronas_por_capa(m);
            
            V{m} = zeros(1, neuronas_capa + 1);
            h{m} = zeros(1, neuronas_capa + 1);
            delta{m} = zeros(1, neuronas_capa + 1);
            
            V{m}(1) = -1;
            h{m}(1) = -1;   % Clave! (Cuanto debe valer esto???)
            for i = 2 : neuronas_capa + 1
                h{m}(i) = sum(pesos{m}(i-1,:) .* V{m-1});
                V{m}(i) = g(h{m}(i), beta);
            end
        end
           
out = V{cant_capas}(2);