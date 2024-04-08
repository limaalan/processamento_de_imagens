%% slide 42
pkg load image ;

height = 0
width = 0
img = imread("imagem.jpg");
img_saida = zeros(width, height, "uint8");
nv_intensidade = 255;

[width, height] = size(img);

img_saida = zeros (width, height);
pr = zeros (0,255);
sk = zeros (0,255);
vetor = zeros (0,255);

%figure(1)
%imhist(img)

%Counts = quantidade de pixels  / MN
[counts , x] = imhist(img);

for i=0:255
  pr(i+1) = counts(i+1) / (width * height);
 endfor

 %Calculando a função de transformação
 sk(1) = nv_intensidade * pr(1);
 for i = 1 :255
   sk(i+1) = nv_intensidade * pr(i+1); %calcula sk atual
   sk(i+1) = sk(i+1) +  sk(i); % faz o somatório
 endfor

x = 0:255;
figure, plot(x,sk);

%Arredondando resultados
for i = 0:255
  sk(i+1) = round(sk(i+1));
endfor

%Criando a imagem de saída
for i = 1:width
  for j = 1:height
    img_saida(i,j) = sk(img(i,j)+1);
  endfor
endfor

%Convertendo para uint8
img_saida = uint8(img_saida);

%Exibindo resultado
figure, imshow(img)
figure, imshow(img_saida)

%Salvando resultado
imwrite(img_saida,"imgsaida.jpg")
