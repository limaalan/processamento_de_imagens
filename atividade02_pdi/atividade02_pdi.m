% 3 for , cada um uma parte da equação, do zero até o ponto 1, do ponto 1 ao ponto 2 e do ponto 2 até 255
% colocar esses valores em um vetor, e aplicar a imagem, fazer um plot para o vetor

% Carregando a imagem original e a imagem de saída como uma matriz de zeros
img = imread ("pollen.jpg");
img_saida = zeros(size(img));

%Definindo os pontos para alteração na curva de contrates
p0 = [0,0]     %ponto inicial
p1 = [90,40]   %ponto personalizado 1
p2 = [140,200] %ponto personalizado 2
p3 = [255,255] %ponto final

%Parâmetros para as funções
%Função 1 : y = (4/9)x
%Função 2 : y = (16/5)x - 248
%Função 3 : y = (11/23)x + (3060/23)

%Montando a função de transformação
funcao =zeros(256);

%Aplicando Função 1
for i = 0:90
  %disp(i)
  funcao(i+1) = (4/9)*i ;
 endfor

%Aplicando Função 2
for i= 91:140
  funcao(i+1) = (16/5)*i -248 ;
 endfor

%Aplicand Função 3
for i = 141:255
  funcao(i+1) = (11/23)*i + (3060/23);
endfor

%Plotando a função de transformação
x = 0:255;
plot(x,funcao)

%Criando a imagem de saída
%Obtendo dimensões da imagem original
rows = size (img,1);
cols = size (img,2);

%Percorrendo pixel a pixel e aplicando a função de transformação
for i=1:rows
  for j=1:cols

    intensidade_pixel = img(i,j);
    img_saida(i,j) = funcao(floor(intensidade_pixel));
    %img_saida(i,j) = intensidade_pixel;
    %img_saida(i,j) = funcao(floor(intensidade_pixel) + 1);

  endfor
endfor

%Convertendo para uint8...
uint8img_saida = uint8(img_saida);

%Exibindo resultado
figure, imshow(img)
figure, imshow(uint8img_saida)


