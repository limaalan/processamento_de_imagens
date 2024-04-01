%Atividade 02 de Processamento de imagens , entrega 02/04/2024
%Alunos : Alan Lima Marques, Thiago Jacomo, Guilherme Inoue

% Carregando a imagem original e a imagem de saída como uma matriz de zeros
img = imread ("pollen.jpg");
img_saida = zeros(size(img));

%Definindo os pontos para alteração na curva de contrates
p0 = [0,0]     %ponto inicial
%p1 = [90,40]   %ponto personalizado 1
p1 = [90,20]   %ponto personalizado 1
%p2 = [140,200] %ponto personalizado 2
p2 = [160,220] %ponto personalizado 2
p3 = [255,255] %ponto final

%Calculando os coeficientes angulares das retas
m0 =  ( p1(2) - p0(2) ) / (p1(1) - p0(1))  % Reta p0 -> p1
m1 =  ( p2(2) - p1(2) ) / (p2(1) - p1(1))  % Reta p1 -> p2
m2 =  ( p3(2) - p2(2) ) / (p3(1) - p2(1))  % Reta p2 -> p3

%Iniciando a função de transformação
funcao =zeros(256);
funcao2 = zeros(256);

%Aplicando Função 1
for i = 0:p1(1)
  funcao(i+1) = p0(2) + m0 * (i - p0(1)) ;
 endfor

%Aplicando Função 2
for i = p1(1)+1:p2(1)
  funcao(i+1) = p1(2) + m1 * (i - p1(1)) ;
 endfor

%Aplicand Função 3
for i = p2(1)+1:p3(1)
  funcao(i+1) = p2(2) + m2 * (i - p2(1)) ;
endfor

%Plotando a função de transformação
x = 0:255;
plot(x,funcao)

%Obtendo dimensões da imagem original
rows = size (img,1);
cols = size (img,2);

%Percorrendo pixel a pixel e aplicando a função de transformação
for i=1:rows
  for j=1:cols

    intensidade_pixel = img(i,j);
    img_saida(i,j) = funcao(floor(intensidade_pixel));

  endfor
endfor

%Convertendo para uint8...
uint8img_saida = uint8(img_saida);

%Exibindo resultado
figure, imshow(img)
figure, imshow(uint8img_saida)

%Salvando no disco
imwrite(uint8img_saida,"imgsaida.jpg")

% Comparação das imagens :
% Foram testados dois conjuntos de pontos para alteração da curva de contrates da imagem
% sendo esses a =(90,40) b =(140,200) e c =(90,20) d=(160,220)
% o resultado com os pontos c e d ficou mais escuro ,
% porém o resultado com os pontos a e b tiveram alguns pixels preto se destacando de maneira estranha , como pode ser visto no canto inferior esquerdo da imagem
% Os resultados podem ser comparados nos arquivos imgsaida.jpg e imgsaida1.jpg
