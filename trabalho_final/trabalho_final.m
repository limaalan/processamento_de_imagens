%Trabalho final da disciplina de Processamento de imagens
% Alunos : Alan Lima Marques, Thiago Roberto Jacomo , Guilherme Inoue

% Carregar e exibir a imagem original em RGB
pkg load image
img_original = imread('Imagem.jpg');
figure,imshow(img_original);
title('Imagem Original RGB');

% Transformando em double e calculando dimensões da imagem
img_original=im2double(img_original);
[x,y,z] = size(img_original)

%Transformando modelo de cor da imagem para HSV , e separando canal de brilho da imagem
imagem_hsv = rgb2hsv(img_original);
imagem_hsv = im2double(imagem_hsv);
imagem_value = imagem_hsv(1:x,1:y,3);
figure, imshow(imagem_value);
title("Canal 'Value' da imagem em HSV ")

% Aplicando a FFT e centralizando
P = x * 2;
Q = y * 2;
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
title("Filtro notch");
filtro_notch = im2double(filtro_notch);

% aplicando o filtro, descentralizando e extraindo a parte real
resultado_aplicacao_filtro = transformada .* filtro_notch;
resultado_aplicacao_filtro = ifftshift(resultado_aplicacao_filtro);
resultado_aplicacao_filtro = ifft2(resultado_aplicacao_filtro);
resultado_aplicacao_filtro = real(resultado_aplicacao_filtro);

% extraindo a parte real do resultado
resultado = im2double(resultado_aplicacao_filtro);
resultado = resultado(1:x,1:y);

% reconstituindo a imagem, devolvendo o resultado ao terceiro canal (V)
imagem_hsv = imagem_hsv(1:x, 1:y ,1:2);
imagem_hsv = cat ( 3, imagem_hsv , resultado);

resultado_final = hsv2rgb(imagem_hsv);
figure, imshow(resultado_final);
title("Resultado final");
imwrite(resultado_final, "resultado_filtragem.png")

%------------------- Correção de contraste -------------------------%

% Calcular o histograma
[counts, binLocations] = imhist(resultado_final);

% Calcular o CDF (Cumulative Distribution Function)
cdf = cumsum(counts) / numel(resultado_final);

% Definir os limites inferior e superior da intensidade desejada
low_in = 0.0; % dos pixels mais escuros
high_in = 0.9; % dos pixels mais claros

% Encontrar os níveis de intensidade correspondentes aos percentis desejados
low_limit = find(cdf >= low_in, 1);
high_limit = find(cdf >= high_in, 1);

% muda a faixa do intervalo de intensidade
contraste_ajustado = imadjust(resultado_final, [low_limit/255, high_limit/255], [0.1,1]);

% Exibindo e salvando a imagem com correção de contraste
figure, imshow(contraste_ajustado);
title("Resultado final com contraste ajustado");
imwrite(contraste_ajustado,"resultado_final.png");

