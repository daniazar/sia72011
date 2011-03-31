N = 2;
neuronas = [2 2 1];
tolerancia = 0.01;

[entrenamiento, respuestas, pesos] = parametros (N, neuronas);
[pesos, epocas] = red (neuronas, entrenamiento, respuestas, pesos, tolerancia);

