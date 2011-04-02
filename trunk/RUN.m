function RUN()

[tolerancia,  eta, beta, neuronas_por_capa] = constantes;
[entrenamiento, respuestas, pesos] = parametros2 ( 0.5, neuronas_por_capa);
[pesos, epocas, resp] = red (neuronas_por_capa, entrenamiento, respuestas, pesos, tolerancia, eta, beta);