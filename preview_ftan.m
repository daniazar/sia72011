function preview_ftan(beta)

figure;
plot (-4:0.1:4, tanh((-4:0.1:4).*beta) );

figure;
plot (-4:0.1:4, beta*(1-g(-4:0.1:4).^2) );

end