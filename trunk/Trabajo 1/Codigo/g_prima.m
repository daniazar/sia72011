function gp = g_prima(x, beta, type)
 fun = g(x,beta,type);
if (type == 1)
    gp = beta*(1-fun^2);
end

% Funcion exponencial

if (type == 2)
    gp = 2 * beta * fun * (1-fun);
end
gp = gp + 0.1;