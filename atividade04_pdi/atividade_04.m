%% slide 42 
pkg load image ;

%Carregando imagens
img = imread("pratica4.jpg");
[width, height ] = size(img);
img_saida = zeros(height, width);
nv_intensidade = 255;

%Convertendo para double 
img = im2double(img);
img_original = img ; 
img_saida = im2double(img_saida);

%Variáveis
tam_filtro = 9;
filtro = zeros(tam_filtro,tam_filtro);

%Montando o filtro de médiag
for i=1:tam_filtro
  for j=1:tam_filtro
    filtro(i,j) = 1/(tam_filtro *tam_filtro);
  endfor
endfor


%Aplicando o filtro na imagem
img_saida = filter2(filtro,img) ;

%Exibindo e salvando a imagem
imshow(img_saida);
imwrite(img_saida,"imgsaida.jpg")
%Essa imagem ficou com uma borda preta por conta de estratégia escolhida para lidar
%com o problema dos pixels da borda. A função filter2 adota como abordagem padrão
%preencher os pixels de fora da imagem com o valor de intesidade 0 , o que escurece o 
%pixel resultante quando se faz cálculos próximos a borda.

%Criando um padding na imagem, aplicando o filtro, exibindo e salvando
img = padarray( img, [tam_filtro-1 , tam_filtro-1] , 'replicate');
img_saida = filter2(filtro,img,'valid');
figure, imshow(img_saida);
imwrite(img_saida,"imgsaida2.jpg")

%passo 6....




