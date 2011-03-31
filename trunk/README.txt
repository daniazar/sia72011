[tolerancia,  eta, beta, N, neuronas_por_capa] = constantes
[entrenamiento, respuestas, pesos] = parametros (N, neuronas);
[pesos, epocas] = red (neuronas, entrenamiento, respuestas, pesos, tolerancia);

