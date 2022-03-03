function img = noisefilter(im, pixel)
    [h, w, ~] = size(im);
    imgA = imadjust(im);
    
    img_fft = fft2(imgA);            
    img_fft(1,1) = 0;               
    
    a = floor(w/2-pixel);
    b = floor(h/2-pixel);
    pos = [8, 8, a, b];
    imgB = SynthesizeFilter(h, w, pos);

    imgC = ifft2(fftshift(imgB).*img_fft); %filtering
    
    imgC = real(imgC);  
    imgC = uint8(255*(imgC - min(min(imgC))) /(max(max(imgC)) - min(min(imgC))));
    img = imadjust(imgC);
end    