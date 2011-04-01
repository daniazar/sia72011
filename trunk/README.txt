[tolerancia,  eta, beta, neuronas_por_capa] = constantes;
[entrenamiento, respuestas, pesos] = parametros (neuronas_por_capa);
[pesos, epocas] = red (neuronas_por_capa, entrenamiento, respuestas, pesos, tolerancia, eta, beta);

a=4;
a=3;
a=2;
a=1;
[out] = testeo_red (entrenamiento(a,:), neuronas_por_capa, pesos, tolerancia, eta, beta)