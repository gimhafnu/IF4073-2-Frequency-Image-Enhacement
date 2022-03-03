function img = SynthesizeFilter(h, w, pos)

    img = ones([h w]);
    
    xmin = pos(1);
    ymin = pos(2);
    width = pos(3);
    height = pos(4);
    
    img(ymin:ymin+height, xmin:xmin+width) = 0;
    
    ymin2 = h - pos(2) - height+3;
    img(ymin2:ymin2+height, xmin:xmin+width) = 0;
    
    xmin2 = w - pos(1) - width+3;
    img(ymin:ymin+height, xmin2:xmin2+width) = 0;
    img(ymin2:ymin2+height, xmin2:xmin2+width) = 0;
end