function preview_input_2 ()

x = -3:0.1:3;
y = -3:0.1:3;
[xx,yy] = meshgrid(x,y);

z = 3.*((1-xx).^2).*exp(-xx.^2-(yy-1).^2);

mesh (x,y,z);
title('Superficie Original');
xlabel('X');
ylabel('Y');
zlabel('Z');

end
