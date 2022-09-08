function [output_img] = mean_filter_2D(input_img, filterLen)

% input_img: one channel of a color image
% filterLen: the length of a filter
%
% output_img: result of using arithimatic_mean_filter


d = floor(filterLen / 2); % distance from center of the filter
[h, w] = size(input_img);
output_img = zeros(h, w);

% calculate the intensity for each pixel of output image
for r = 1:h
    for c = 1:w
        numerator = double(0);
        %denominator = double(0);
        % iterate the square size of filter
        for i = (r - d):(r + d)
            for j = (c - d):(c + d)
                % avoid out of range
                if i >= 1 && i <= h && j >= 1 && j <= w
                    numerator = numerator + double(input_img(i, j));
                    %denominator = denominator + double(input_img(i, j))^Q;
                end
            end
        end
        output_img(r, c) = numerator / (filterLen)^2;
    end
end
output_img = uint8(output_img);
end