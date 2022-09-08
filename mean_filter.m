function [output_mean_img,output_mean_enhanced_img] = mean_filter(noise_img, filterLen)
% Get the dimensions of the image.  numberOfColorBands should be = 3.
[rows columns numberOfColorBands] = size(noise_img);
% Display the original color image.
fontSize=10;

% Extract the individual red, green, and blue color channels.
redChannel = noise_img(:, :, 1);
greenChannel = noise_img(:, :, 2);
blueChannel = noise_img(:, :, 3);
%figure;


% Median Filter the channels:
redMF = mean_filter_2D(redChannel,3);
greenMF = mean_filter_2D(greenChannel, 3);
blueMF = mean_filter_2D(blueChannel, 3);


output_mean_img = cat(3, redMF,greenMF,blueMF);
noiseFreeRed_clh_img= clahe_equalisation(redMF,8,128,4,4);%img,clip_limit,nr_bins,nr_x,nr_y
noiseFreeGreen_clh_img= clahe_equalisation(greenMF,8,128,4,4);
noiseFreeBlue_clh_img= clahe_equalisation(blueMF,8,128,4,4);

output_mean_enhanced_img = cat(3, noiseFreeRed_clh_img,noiseFreeGreen_clh_img,noiseFreeBlue_clh_img);
end