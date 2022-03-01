function filtered_image_wrapper = highPassFilterWrapper(f, filter_name)
    [M, N, C] = size(f);
    P = 2*M;
    Q = 2*N;
    g = zeros([P Q C]);
    f = im2double(f);
    fp = zeros([P Q C]);
    for c = 1:C
        for i = 1 : P
            for j = 1 : Q
                if i <= M && j <= N
                    fp(i,j,c) = f(i,j,c);
                else
                    fp(i,j,c) = 0;
                end
            end
        end
    end
    for c = 1:C
        f_temp = fp(:,:,c);
        filtered_image = highPassFilter(f_temp, filter_name);
        g(:,:,c) = filtered_image(:,:,1);
    end
    g=g(1:M, 1:N, :);
    filtered_image_wrapper = g;
end