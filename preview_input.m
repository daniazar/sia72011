function preview_input ()

x = -3:0.1:3;
y = -3:0.1:3;

z = 3.*((1-x).^2).*exp(-x.^2-(y-1).^2);


plot3 (x,y,z);

end