%Atividade 04 de Processamento de imagens , entrega 15/04/2024
%Alunos : Alan Lima Marques, Thiago Jacomo, Guilherme Inoue

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
imwrite(img_saida,"img_saida_filtro.jpg")

% Essa imagem ficou com uma borda preta por conta de estratégia escolhida para lidar
% com o problema dos pixels da borda. A função filter2 adota como abordagem padrão
% preencher os pixels de fora da imagem com o valor de intesidade 0 , o que escurece o 
% pixel resultante quando se faz cálculos próximos a borda. 

%Criando um padding na imagem, aplicando o filtro, exibindo e salvando
img = padarray( img, [(tam_filtro-1)/2 ,( tam_filtro-1)/2] , 'replicate');
img_saida = filter2(filtro,img,'valid');
figure, imshow(img_saida);
imwrite(img_saida,"img_saida_filtro_padding.jpg")

%Montando os filtros de sobel
filtro_sobel_1 = [-1 -2 -1 ; 0 0 0 ; 1 2 1]
filtro_sobel_2 = [-1 0 1 ; -2 0 2 ; -1 0 1]
img_sobel_1 = padarray( img_original, [1, 1] , 'replicate');
img_sobel_2 = padarray( img_original, [1, 1] , 'replicate');
img_saida_sobel_1=filter2(filtro_sobel_1,img_sobel_1,'valid') ;
img_saida_sobel_2=filter2(filtro_sobel_2,img_sobel_2,'valid') ;

%Aplicando filtros
figure, imshow(img_saida_sobel_1);
figure, imshow(img_saida_sobel_2);

%Calculando a magnitude do gradiente 
img_saida_sobel = zeros (width );
img_saida_sobel = im2double (img_saida_sobel);
for i=1:width
  for j=1:height
    img_saida_sobel(i,j) =abs(img_saida_sobel_1(i,j)) + abs(img_saida_sobel_2(i,j)) ;
  endfor
endfor

%Salvando e exibindo
figure, imshow(img_saida_sobel);
imwrite(img_saida_sobel,"img_saida_filtro_sobel.jpg")



