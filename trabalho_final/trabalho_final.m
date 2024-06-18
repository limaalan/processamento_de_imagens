pkg load image;

% Passo 0: Carregar e exibir a imagem original em RGB
img_original = imread('Imagem.jpg');
figure,imshow(img_original);
title('Imagem Original RGB');

img_original=im2double(img_original);
[x,y,z] = size(img_original)

%Transformando modelo de cor da imagem para HSV , e separando canal de brilho da imagem%
imagem_hsv = rgb2hsv(img_original);
imagem_hsv = im2double(imagem_hsv);
imagem_value = imagem_hsv(1:x,1:y,3);
figure, imshow(imagem_value);
title("Canal 'Value' da imagem em HSV ")

%Definindo parâmetros
P = x * 2;
Q = y * 2;

% Aplicando a FFT e centralizando , as dimensões da transformada P e Q
% são o dobro das dimensões originais da imagem .
transformada = fft2(imagem_value, P, Q);
transformada = fftshift(transformada);

% calculando a magnitude da transformada para visualização .
imagem_fft = uint8(abs(transformada));
figure, imshow(imagem_fft);
title("Espectro");
imwrite(imagem_fft, "espectro.png");

% carregando o filtro notch, criado manualmente em um programa de edição de imagens
filtro_notch = imread("filtro.png");
figure, imshow(double(filtro_notch));
title("Filtro notch ");

filtro_notch = im2double(filtro_notch);

% aplicando o filtro, descentralizando e extraindo a parte real
resultado_aplicacao_filtro = transformada .* filtro_notch;
resultado_aplicacao_filtro = ifftshift(resultado_aplicacao_filtro);
resultado_aplicacao_filtro = ifft2(resultado_aplicacao_filtro);
resultado_aplicacao_filtro = real(resultado_aplicacao_filtro);

% convertendo para uint8 e visualizando resultado.
%resultado = im2uint8(resultado_aplicacao_filtro);
resultado = im2double(resultado_aplicacao_filtro);
resultado = resultado(1:x,1:y);

%Exibindo resultado da filtragem no canal 'Value'
%figure, imshow(resultado);
%title("Imagem filtrada");
%imwrite(resultado, "resultado.png");

imagem_hsv = imagem_hsv(1:x, 1:y ,1:2);
imagem_hsv = cat ( 3, imagem_hsv , resultado);

resultado_final = hsv2rgb(imagem_hsv);
figure, imshow(resultado_final);
title("Resultado final");
imwrite(resultado_final, 'resultado_final.png')


