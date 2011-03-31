[tolerancia,  eta, beta, N, neuronas_por_capa] = constantes;
[entrenamiento, respuestas, pesos] = parametros (N, neuronas_por_capa);
[pesos, epocas] = red (neuronas_por_capa, entrenamiento, respuestas, pesos, tolerancia, eta, beta);