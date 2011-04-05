[tolerancia,  eta, beta, neuronas_por_capa] = constantes;
[entrenamiento, respuestas, pesos] = parametros (neuronas_por_capa);
[pesos, epocas] = red (neuronas_por_capa, entrenamiento, respuestas, pesos, tolerancia, eta, beta);

a=1;
[out] = testeo_red (entrenamiento(a,:), neuronas_por_capa, pesos, tolerancia, eta, beta)

a=2;
[out] = testeo_red (entrenamiento(a,:), neuronas_por_capa, pesos, tolerancia, eta, beta)

a=3;
[out] = testeo_red (entrenamiento(a,:), neuronas_por_capa, pesos, tolerancia, eta, beta)

a=4;
[out] = testeo_red (entrenamiento(a,:), neuronas_por_capa, pesos, tolerancia, eta, beta)