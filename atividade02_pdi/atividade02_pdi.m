% 3 for , cada um uma parte da equação, do zero até o ponto 1, do ponto 1 ao ponto 2 e do ponto 2 até 255
% colocar esses valores em um vetor, e aplicar a imagem, fazer um plot para o vetor

% Carregando a imagem original e a imagem de saída como uma matriz de zeros
img = imread ("pollen.jpg");
img_saida = zeros(size(img));
img_saida2 = zeros(size(img));
%90,40
%160,220

%Definindo os pontos para alteração na curva de contrates
p0 = [0,0]     %ponto inicial
p1 = [90,40]   %ponto personalizado 1
p2 = [140,200] %ponto personalizado 2
p3 = [255,255] %ponto final
p4 = [95,45] %ponto personalizado 3
p5 = [145,210] %ponto personalizado 4

%Parâmetros para as funções
%Função 1 : y = (4/9)x
%Função 2 : y = (16/5)x - 248
%Função 3 : y = (11/23)x + (3060/23)


%Função 4 : y = 0.65x
%Função 5 : y = 2.4285x + 144.28
%Função 6 : y = (1/3)x + 170

%Montando a função de transformação
funcao =zeros(256);
funcao2 = zeros(256);

%Aplicando Função 1
for i = 0:90
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

%Segunda função
for i=0:p4(1)
funcao2(i+1) = 0.473*i;
endfor

for i=p4(1)+1:p5(1)
 funcao2(i+1) = 3.3*i  - 268.5;
endfor

for i = p5(1)+1:255
 funcao2(i+1) = (0.409)*i + 150.68;
endfor


%Plotando a função de transformação
x = 0:255;
plot(x,funcao)
figure, plot(x,funcao2)

%Criando a imagem de saída
%Obtendo dimensões da imagem original
rows = size (img,1);
cols = size (img,2);

%Percorrendo pixel a pixel e aplicando a função de transformação
for i=1:rows
  for j=1:cols

    intensidade_pixel = img(i,j);
    img_saida(i,j) = funcao(floor(intensidade_pixel));
    img_saida2(i,j) = funcao2(floor(intensidade_pixel));
    
  endfor
endfor

%Convertendo para uint8...
uint8img_saida = uint8(img_saida);
uint8img_saida2 = uint8(img_saida2);

%Exibindo resultado
figure, imshow(img)
figure, imshow(uint8img_saida)
figure, imshow(uint8img_saida2)

%Salvando no disco
imwrite(uint8img_saida,"imgsaida.jpg")
imwrite(uint8img_saida2,"imgsaida2.jpg")

% Comparação das imagens : 
% O alongamento de constrate com os pontos p4(95,45) e p5(145,210) gerou uma imagem mais nítida e com menos pixels pretos se destacando

