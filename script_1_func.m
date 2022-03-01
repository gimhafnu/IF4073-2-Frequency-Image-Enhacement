
f=imread('images\3-1-2.png');
figure, imshow(f); title("input image");
filter = "Butterwoth"; %Ideal, Gaussian, Butterwoth

g = lowpass_frequency_wrapper(f, filter);
figure, imshow(g); title('MY GOD WHY');

%% Display the Fourier Spectrum
if size(g,3) == 1
    Fc=fftshift(fft2(f)); % move the origin of the transform to the center of the frequency rectangle
    S2=log(1+abs(Fc)); % use abs to compute the magnitude (handling imaginary) and use log to brighten display
    figure, imshow(S2,[]); title('Fourier spectrum');
else
    Fc1=fftshift(fft2(g(:,:,1))); % move the origin of the transform to the center of the frequency rectangle
    S21=log(1+abs(Fc1)); % use abs to compute the magnitude (handling imaginary) and use log to brighten display
    Fc2=fftshift(fft2(g(:,:,2))); % move the origin of the transform to the center of the frequency rectangle
    S22=log(1+abs(Fc2)); % use abs to compute the magnitude (handling imaginary) and use log to brighten display
    Fc3=fftshift(fft2(g(:,:,3))); % move the origin of the transform to the center of the frequency rectangle
    S23=log(1+abs(Fc3)); % use abs to compute the magnitude (handling imaginary) and use log to brighten display
    figure,
    subplot(2,2,1), imshow(S21,[]), title("r")
    subplot(2,2,2), imshow(S21,[]), title("g")
    subplot(2,2,3), imshow(S22,[]), title("b");
    

end
