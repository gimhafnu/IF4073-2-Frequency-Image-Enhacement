function fourier_spectrum(f)
    if size(f,3) == 1
        Fc=fftshift(fft2(f)); % move the origin of the transform to the center of the frequency rectangle
        S2=log(1+abs(Fc)); % use abs to compute the magnitude (handling imaginary) and use log to brighten display
        imshow(S2,[]);
    end