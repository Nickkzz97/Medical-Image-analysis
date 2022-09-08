function clh_img= clahe_equalisation(img,clip_limit,nr_bins,nr_x,nr_y)
% img_hsv=rgb2hsv(img);
% %img = rgb2lab(img);
% img=img_hsv(:,:,3);
% %img=255*img;
%img=img(:,:,3);
img = im2uint8(img);
%figure,imshow(img)
[h,w]=size(img);
if clip_limit == 1
       return;
end
%nr_bins=64, nr_x=4, nr_y=4;
nr_bins = max(nr_bins, 32);
    if nr_x == 0
        x_sz = 32;
        y_sz = 32;

        nr_x = ceil(h / x_sz);
        exc_x = ceil(x_sz * (nr_x - h / x_sz));

        nr_y = ceil(w / y_sz);
        exc_y = ceil(y_sz * (nr_y - w / y_sz));
        if exc_x ~= 0
             img = cat(2, img, zeros(h,exc_x));
        end
        if exc_y ~= 0
            img = cat(1, img, zeros( exc_y,w+exc_x));
        end
    
   else
        x_sz = round(h / nr_x);
        y_sz = round(w / nr_y);
        exc_x = ceil(x_sz * (nr_x - h / x_sz));
        exc_y = ceil(y_sz * (nr_y - w / y_sz));
        if exc_x ~= 0
            img = cat(2, img, zeros(h,exc_x));
        end
        if exc_y ~= 0
            img = cat(1, img, zeros(exc_y,w+exc_x));
        end
    end
    
nr_pixels = x_sz * y_sz;
claheimg = zeros(h, w);
if clip_limit > 0
        clip_limit = max(1, clip_limit * x_sz * y_sz / nr_bins)
    else
        clip_limit = 50;
end

% Look up table
%  To speed up histogram clipping, the input image [Min,Max] is scaled down to
%  [0,NrBins-1]. 

 min_val = 0;
    max_val = 256;

    bin_sz = floor(1 + (max_val - min_val) / nr_bins);
    LUT = floor((min_val:1/bin_sz:floor(max_val/bin_sz)) - min_val / bin_sz);

    bins = LUT(img+1);
%% Making Histogram Plane
%  This function classifies the greylevels present in the array image into
%  a greylevel histogram. The pLookupTable specifies the relationship
%  between the greyvalue of the pixel (typically between 0 and 4095) and
%  the corresponding bin in the histogram (usually containing only 128 bins).

    hist = zeros(nr_x, nr_y, nr_bins);
    for i=0:nr_x-1
        for j=0:nr_y-1
            bin_ = bins(i * x_sz + 1:(i + 1) * x_sz, j * y_sz + 1:(j + 1) * y_sz);
            for i1=0:x_sz-1
                for j1=0:y_sz-1
                    hist(i+1, j+1, bin_(i1+1, j1+1)+1) = hist(i+1, j+1, bin_(i1+1, j1+1)+1) + 1;
                end
            end
        end
    end
%% Histogram Clipping
%  This function performs clipping of the histogram and redistribution of bins.
%  The histogram is clipped and the number of excess pixels is counted. Afterwards
%  the excess pixels are equally redistributed across the whole histogram (providing
%  the bin count is smaller than the cliplimit).

    if clip_limit > 0
        for i=1:nr_x
            for j=1:nr_y
                nr_excess = 0;
                for nr=1:nr_bins
                    excess = hist(i, j, nr) - clip_limit;
                    if excess > 0
                        nr_excess = nr_excess + excess;
                    end
                end

                bin_incr = nr_excess / nr_bins;
                upper = clip_limit - bin_incr;

                for nr=1:nr_bins
                    if hist(i, j, nr) > clip_limit
                        hist(i, j, nr) = clip_limit;
                    else
                        if hist(i, j, nr) > upper
                            nr_excess = nr_excess + upper - hist(i, j, nr);
                            hist(i, j, nr) = clip_limit;
                        else
                            nr_excess = nr_excess - bin_incr;
                            hist(i, j, nr) = hist(i, j, nr) + bin_incr;
                        end
                    end
                end
                if nr_excess > 0
                    step_sz = max(1, floor(1 + nr_excess / nr_bins));
                    for nr=1:nr_bins
                        nr_excess = nr_excess - step_sz;
                        hist(i, j, nr) = hist(i, j, nr) + step_sz;
                        if nr_excess < 1
                            break
                        end
                    end
                end
            end
        end
    end
    %% Mapping the Histogram
    %  This function calculates the equalized lookup table (mapping) by
    %  cumulating the input histogram. Note: lookup table is rescaled in range [Min..Max].
    map_ = zeros(nr_x, nr_y, nr_bins);
    scale = (max_val - min_val) / nr_pixels;
    for i=1:nr_x
        for j=1:nr_y
            sum_ = 0;
            for nr=1:nr_bins
                sum_ = sum_ + hist(i, j, nr);
                map_(i, j, nr) = floor(min(min_val + sum_ * scale, max_val));
            end
        end
    end
%% Interpolation
%  This function calculates the new greylevel assignments of pixels within a submatrix
%  of the image with size uiXSize and uiYSize. This is done by a bilinear interpolation
%  between four different mappings in order to eliminate boundary artifacts.
%  It uses a division; since division is often an expensive operation

    x_I = 1;
    for i=0:nr_x
        if i == 0
            sub_x = floor(x_sz / 2);
            x_u = 0;
            x_b = 0;
        elseif i == nr_x
            sub_x = floor(x_sz / 2);
            x_u = nr_x - 1;
            x_b = nr_x - 1;
        else
            sub_x = x_sz;
            x_u = i - 1;
            x_b = i;
        end

        y_I = 1;

        for j=0:nr_y
            if j == 0
                sub_y = floor(y_sz / 2);
                y_l = 0;
                y_r = 0;
            elseif j == nr_y
                sub_y = floor(y_sz / 2);
                y_l = nr_y - 1;
                y_r = nr_y - 1;
            else
                sub_y = y_sz;
                y_l = j - 1;
                y_r = j;
            end
            UL = map_(x_u+1, y_l+1, :);
            UR = map_(x_u+1, y_r+1, :);
            BL = map_(x_b+1, y_l+1, :);
            BR = map_(x_b+1, y_r+1, :);

            sub_bin = bins(x_I:x_I + sub_x-1, y_I:y_I + sub_y-1);

            subImage = interpolate(sub_bin, UL, UR, BL, BR, sub_x, sub_y);
            claheimg(x_I:x_I + sub_x-1, y_I:y_I + sub_y-1) = subImage;
            y_I = y_I + sub_y;
        end
        x_I = x_I + sub_x;
    end

    if exc_x == 0 && exc_y ~= 0
        clh_img = claheimg(:, 1:-exc_y);
    elseif exc_x ~= 0 && exc_y == 0
        clh_img = claheimg(1:-exc_x);
    elseif exc_x ~= 0 && exc_y ~= 0
        clh_img = claheimg(1:-exc_x, 1:-exc_y);
    else
        clh_img = claheimg;
    end
end