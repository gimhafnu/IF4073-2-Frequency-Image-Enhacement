function filtered_image = lowpass_frequency(f, filter_name) % filter_name is %Ideal, Gaussian, Butterwoth        
    [P,Q] = size(f);

    F = fft2(double(f));
    %% Make the H filter function
    D0 = 0.05*P;
    u = 0:(P-1);
    v = 0:(Q-1);
    % Get meshgrid indices
    idx = find(u > P/2);
    u(idx) = u(idx) - P;
    idy = find(v > Q/2);
    v(idy) = v(idy) - Q;
    % Compute Meshgrid arrays
    [V, U] = meshgrid(v, u);
    D = sqrt(U.^2 + V.^2);
    H = 0;
    %% %% Calculate the LPF Gaussian
    if filter_name == "Gaussian"
        H = exp(-(D.^2)./(2*(D0^2)));
    %% %% Calculate the LPF Ideal
    elseif filter_name == "Ideal"
        H = exp(-(D.^2)./(2*(D0^2)));
    %% %% Calculate the LPF Butterwoth
    elseif filter_name == "Butterwoth"
        n = 1; % default
        H = 1./(1 + (D./D0).^(2*n));
    end
    %figure;imshow(H);title('LPF Mask');
    
    %g = zeros([P Q C], "uint8");
    %% Fast Fourier Transform
    %F = fft2(double(f(:,:,c)));
    % disp(c);
    
    %% Multiply F with the H filter
    G = H.*F;
    
    %% Get the real portion of the ifft of G
    
    %figure;imshow(real(ifft2(G)));title('AAAAA');
    
    filtered_image = real(ifft2(G));
end