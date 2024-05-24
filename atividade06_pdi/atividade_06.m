% Atividade 06 de Processamento de imagens, entrega com vencimento 04/06/2024
% Alunos: Alan Lima Marques, Thiago Jacomo, Guilherme Inoue
pkg load image;

% Carregando imagens
img = imread("pratica6.png");
figure, imshow(img);
title("Imagem original ");

[width, height] = size(img);

% Convertendo para double
img = im2double(img);

P = width * 2;
Q = height * 2;

% Aplicando a FFT e centralizando , as dimensões da transformada P e Q
% são o dobro das dimensões originais da imagem .
transformada = fft2(img, P, Q);
transformada = fftshift(transformada);

% calculando a magnitude da transformada para visualização .
imagem_fft = uint8(abs(transformada));
figure, imshow(imagem_fft);
title("Espectro ");
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
resultado = im2uint8(resultado_aplicacao_filtro);
resultado = resultado(1:width,1:height);
figure, imshow(resultado);
title("Imagem filtrada");
imwrite(resultado, "resultado.png");

