function answer = desnormalize(resp, answer, type)


min_num = min(resp);
aux = resp + min_num;
max_num = max(aux);

if (type == 1)
    answer = answer + 1;
    answer = answer * (max_num / 2);
end

% Funcion exponencial

if (type == 2)    
   answer = answer + 0.5;
   answer = answer * max_num; 
end

answer = answer - min_num;
