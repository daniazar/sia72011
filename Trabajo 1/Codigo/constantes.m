function [tolerancia,  eta, beta, neuronas_por_capa, alfa, step, type, learn_tole, gen_tole] = constantes()
      tolerancia = 0.03;
      learn_tole = 0.03;
      gen_tole   = 0.06;
      eta = 0.5;
      beta = 0.3;
      neuronas_por_capa = [2 10 6 1]; % El primer valor es la cantidad de entradas.
                                       %El ultimo valor es la capa de salida
      alfa = 0.5;   % MOMENTUM
      step = 0.1;
      type = 2;     % Funcion de activacion
      
      
      
      % 2 6 6 1
      %epocas =  1542
      %globalerror  0.0193
      %learn_rate =   81.5603
      %generalization_rate =   86.2021