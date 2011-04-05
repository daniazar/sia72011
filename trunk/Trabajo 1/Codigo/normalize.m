function answer = normalize(resp, type)

min_num = min(resp);
answer = resp + min_num;
max_num = max(answer);

if (type == 1)
    max_num = max_num / 2;
    answer = answer / max_num;
    answer = answer - 1;
    
end

% Funcion exponencial

if (type == 2)    
   answer = answer / max_num;
   answer = answer - 0.5;
 
end
