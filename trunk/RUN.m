function RUN()

[tolerancia,  eta, beta, neuronas_por_capa] = constantes;
[entrenamiento, respuestas, pesos] = parametros (neuronas_por_capa);
[pesos, epocas] = red (neuronas_por_capa, entrenamiento, respuestas, pesos, tolerancia, eta, beta);