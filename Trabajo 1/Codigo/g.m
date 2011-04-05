function g = g(value, param, type)

% Funcion tangente hiperbolica:

if (type == 1)
    g = tanh(value*param);
end

% Funcion exponencial

if (type == 2)
    g = 1 / (1 + exp(-2*value*param));
end