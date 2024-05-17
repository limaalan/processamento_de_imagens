% Atividade 05 de Processamento de imagens, entrega 21/05/2024
% Alunos: Alan Lima Marques, Thiago Jacomo, Guilherme Inoue
pkg load image;

% Carregando imagens
img = imread("pratica5.png");
[width, height] = size(img);
nv_intensidade = 255;

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
imwrite(imagem_fft, "transformada.jpg");

% definindo d0 e calculando o filtro passa baixa
Dzero = 20;
filtro_passa_baixa = zeros(P, Q,"double");

for i = 1:P
    for j = 1:Q
        D = sqrt((i - P / 2)^2 + (j - Q / 2)^2);
        filtro_passa_baixa(i, j) = e^(-D^2 / ((Dzero^2) *2 ));
        % calc = exp(-D / ((Dzero^2) / 2));
    endfor
endfor

% calculando a magnitude do filtro para visualização
imagem_filtropb = double(abs(filtro_passa_baixa));
figure, imshow(imagem_filtropb);
imwrite(imagem_filtropb, "filtro_passa_baixa.jpg");

% aplicando o filtro, descentralizando e extraindo a parte real
passo8 = transformada .* filtro_passa_baixa;
passo8 = ifftshift(passo8);
passo8 = ifft2(passo8);
passo8 = real(passo8);

% convertendo para uint8 e visualizando resultado.
resultado = im2uint8(passo8);
resultado = resultado(1:width,1:height);
figure, imshow(resultado);
imwrite(resultado, "resultado.jpg");

