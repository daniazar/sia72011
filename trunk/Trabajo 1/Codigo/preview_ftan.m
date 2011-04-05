function preview_ftan(beta)

figure;
plot (-4:0.1:4, tanh((-4:0.1:4).*beta) );

figure;
plot (-4:0.1:4, beta*(1-tanh( (-4:0.1:4).*beta).^2) );

end