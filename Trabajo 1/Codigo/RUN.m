function [pesos, epocas, resp] = RUN(pesos)

epocas = 0;
[tolerancia,  eta, beta, neuronas_por_capa, alfa, step, type, learn_tole, gen_tole] = constantes;

[entrenamiento, respuestas, pesos, delta_pesos_anterior] = parametros3 (step, neuronas_por_capa);

[pesos, epocas, resp] = red (neuronas_por_capa, entrenamiento, respuestas, pesos, delta_pesos_anterior, tolerancia, eta, beta, alfa, type, learn_tole);


[x y z entrenamiento respuestas] = result_param ();

[resp] = result (neuronas_por_capa, entrenamiento, respuestas, pesos, eta, beta, type, x, y ,z, gen_tole);

%
%[entrenamiento, respuestas, pesos, delta_pesos_anterior] = parametros_test (step, neuronas_por_capa);
%
%   Funcion a calcular:
%
%   z = 3 * (1-x)^2 * exp(-x^2 - (y+1)^2 )
%