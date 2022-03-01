function filtered_image = highPassFilter(f, filter_name)
    [P, Q] = size(f);
    
    F = fft2(double(f));
    
    D0 = 0.05*P;
    u = 0:(P-1);
    v = 0:(Q-1);
    
    idx = find(u > P/2);
    u(idx) = u(idx) -P;
    idy = find(v > Q/2);
    v(idy) = v(idy) - Q;
    
    [V,U] = meshgrid(v,u);
    D = sqrt(U.^2 + V.^2);
    
    H = 0;
    %% %% Calculate the HPF Gaussian
    if filter_name == "Gaussian"
        H = exp(-(D.^2)./(2*(D0^2)));
        H = 1-H;
    %% %% Calculate the HPF Ideal
    elseif filter_name == "Ideal"
        H = double(D<=0);
        H= 1-H;
    %% %% Calculate the HPF Butterwoth
    elseif filter_name == "Butterwoth"
        n = 1;
        H= 1./(1 + (D./D0).^(2*n));
    end
    
    HPF_f = H.*F;
    HPF_f2 = real(ifft2(HPF_f));
    % figure; imshow(HPF_f2); title('Outputt image after inverse 2D');
    
%     HPF_f2 = HPF_f2(1:M, 1:N);
    filtered_image = HPF_f2;
end
    

