clear all;
clc;

f=imread('images\1-1-grey.png');
figure, imshow(f); title('original image');

F = fft2(double(f));

G = F * 3;
g=uint8(real(ifft2(G)));
figure, imshow(g); title('output image');
