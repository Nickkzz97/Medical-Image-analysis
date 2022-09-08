function [output_img,output_enhanced_img] = median_filter(noise_img, filterLen)
% Get the dimensions of the image.  numberOfColorBands should be = 3.
[rows columns numberOfColorBands] = size(noise_img);
% Display the original color image.
fontSize=10;

% Extract the individual red, green, and blue color channels.
redChannel = noise_img(:, :, 1);
greenChannel = noise_img(:, :, 2);
blueChannel = noise_img(:, :, 3);


% Median Filter the channels:
redMF = median_filter_2D(redChannel, 3);
greenMF = median_filter_2D(greenChannel, 3);
blueMF = median_filter_2D(blueChannel, 3);

% Find the noise in the red.
noiseImage = (redChannel == 0 | redChannel == 255);
% Get rid of the noise in the red by replacing with median.
noiseFreeRed = redChannel;
noiseFreeRed(noiseImage) = redMF(noiseImage);

% Find the noise in the green.
noiseImage = (greenChannel == 0 | greenChannel == 255);
% Get rid of the noise in the green by replacing with median.
noiseFreeGreen = greenChannel;
noiseFreeGreen(noiseImage) = greenMF(noiseImage);

% Find the noise in the blue.
noiseImage = (blueChannel == 0 | blueChannel == 255);
% Get rid of the noise in the blue by replacing with median.
noiseFreeBlue = blueChannel;
noiseFreeBlue(noiseImage) = blueMF(noiseImage);

% Reconstruct the noise free RGB image
output_img1 = cat(3, noiseFreeRed, noiseFreeGreen, noiseFreeBlue);

output_img = cat(3, redMF,greenMF,blueMF);

%Each channnel enhanced by CLAHE
noiseFreeRed_clh_img= clahe_equalisation(redMF,8,128,4,4);%img,clip_limit,nr_bins,nr_x,nr_y
noiseFreeGreen_clh_img= clahe_equalisation(greenMF,8,128,4,4);
noiseFreeBlue_clh_img= clahe_equalisation(blueMF,8,128,4,4);

output_enhanced_img = cat(3, noiseFreeRed_clh_img,noiseFreeGreen_clh_img,noiseFreeBlue_clh_img);


end