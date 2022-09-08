
function [output_gauss_img,output_gauss_enhanced_img] = Gaussian_filter(noise_img, kernel_size,sigma)
% noise_img=salt_noise_img;
% kernel_size=3;
% sigma=0.4;
% Get the dimensions of the image.  numberOfColorBands should be = 3.
[rows, columns, numberOfColorBands] = size(noise_img);
redChannel = noise_img(:, :, 1); %#ok<*NODEF>
greenChannel = noise_img(:, :, 2);
blueChannel = noise_img(:, :, 3);

% Construct Gaussian Kernel
m=kernel_size; 
n=kernel_size;
%sigma=0.4;
[h1 h2]=meshgrid(-(m-1)/2:(m-1)/2, -(n-1)/2:(n-1)/2);
hg= (2*pi*sigma^2)*exp(-(h1.^2+h2.^2)/(2*sigma^2));            %Gaussian function
h=hg ./sum(hg(:));
% Could be done easier with fspecial though!

% Convolve the three separate color channels.
redBlurred = conv2(redChannel, h);
greenBlurred = conv2(greenChannel, h);
blueBlurred = conv2(blueChannel, h);

redBlurred=imresize(redBlurred,[size(noise_img,1),size(noise_img,2)]);
greenBlurred=imresize(greenBlurred,[size(noise_img,1),size(noise_img,2)]);
blueBlurred=imresize(blueBlurred,[size(noise_img,1),size(noise_img,2)]);

% Recombine separate color channels into a single, true color RGB image.
output_gauss_img = cat(3, uint8(redBlurred), uint8(greenBlurred), uint8(blueBlurred));
%figure,imshow(output_gauss_img);
%figure,imshow(noise_img);
% Display the blurred color image.
%goutput_gauss_img=imresize(output_gauss_img,[size(noise_img,1),size(noise_img,2)]);
redBlurred=imresize(redBlurred,[size(noise_img,1),size(noise_img,2)]);
greenBlurred=imresize(greenBlurred,[size(noise_img,1),size(noise_img,2)]);
blueBlurred=imresize(blueBlurred,[size(noise_img,1),size(noise_img,2)]);
redBlurred=redBlurred./255;
greenBlurred=greenBlurred./255;
blueBlurred=blueBlurred./255;
%re=im2uint8(redBlurred);



noiseFreeRed_clh_img= clahe_equalisation(redBlurred,8,128,4,4);%img,clip_limit,nr_bins,nr_x,nr_y
noiseFreeGreen_clh_img= clahe_equalisation(greenBlurred,8,128,4,4);
noiseFreeBlue_clh_img= clahe_equalisation(blueBlurred,8,128,4,4);

output_gauss_enhanced_img = cat(3, noiseFreeRed_clh_img,noiseFreeGreen_clh_img,noiseFreeBlue_clh_img);
%figure,imshow(uint8(output_gauss_enhanced_img));
end