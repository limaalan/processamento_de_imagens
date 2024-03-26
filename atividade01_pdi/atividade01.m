%pkg load image
img = imread("tungsten_filament_shaded.tif");
sombra = imread("tungsten_sensor_shading.tif");

% Conversão para double
img = im2double(img);
sombra = im2double(sombra);

img_corrigida = (img./sombra);

imshow(img)
figure , imshow(sombra)
figure , imshow(img_corrigida)

%Será necessário fazer o reescalonamento dos valores após a aplicação da operação aritmética apropriada?
%   Sim pois ao realizar uma operação de divisão por elementos, os valores ficam na faixa de 0-1
%   e ao renderizar uma imagem assim, o resultado fica todo escuro pois são valores muito baixos
%   , portanto é necessário fazer reescalonamento dos valores do resultado da operação para que
%   os valores de intensidade das cores sejam exibidas corretamento.

%Qual tipo de dado está sendo utilizado (‘uint8’,‘uint16’,‘double’,· · ·)? Como isso afeta o seu programa ?
% Double, está sendo utilizada para representar corretamente os valores de intensidade resultantes da
% operação de divisão.
