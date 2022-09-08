clc; clear all; close all;
I= imread('27.ppm');
%I=rgb2gray(I);
[R,C,K]= size(I)
%figure(1),subplot(2,3,1);imshow(I);
fontSize=8;
%title('Original color Image', 'FontSize', fontSize);
% Enlarge figure to full screen.
%set(gcf, 'Position', get(0,'Screensize')); 
%% Noise generator

%Salt and pepper noise generator
salt_variance = input('Enter the value of variance of salt & paper noise to be generated between 0 to 1:');
%Mean value for pepper noise in between 0 to 1 and variance for salt noise
%between 0 to 1 and greater than mean
[salt_noise_img] = noise_generator(I, 'salt & pepper',0,salt_variance);

% gaussian noise generator
gaussian_variance = input('Enter the value of standard deviation of Gaussian noise to be generated:');
[gaussian_noise_img] = noise_generator(I, 'gaussian', 0, gaussian_variance);
%figure,imshow(gaussian_noise_img);title(['Gaussian noised image of variancce',num2str(gaussian_variance)]);
% array_gaussian_noise=mu+uint8(abs(floor(randn(R,C)*sigma)));

%% 

%% Noise Filtering for Salt Noise
% Median Filtering
[output_med_filter_img_s,output_enhanced_img_s] = median_filter(salt_noise_img, 3);

% Mean Filtering

[output_mean_img_s,output_mean_enhanced_img_s] = mean_filter(salt_noise_img, 3);


% Gaussian Filtering
[output_Gaussian_filter_img_s,output_gauss_enhanced_img_s] = Gaussian_filter(salt_noise_img, 3,0.4);

%% Noise Filtering for Gaussian noise
% Median Filtering
[output_med_filter_img_g,output_enhanced_img_g] = median_filter(gaussian_noise_img, 3);
% figure(3),subplot(2,3,1), imshow(gaussian_noise_img);
% title('3*3 gaussian noise Image');
% figure(3),subplot(2,3,2),imshow(output_med_filter_img_g);
% title('Median filtered  Image for gaussian noise', 'FontSize', fontSize);
% Mean Filtering
[output_mean_img_g,output_mean_enhanced_img_g] = mean_filter(gaussian_noise_img, 3);
% figure(3),subplot(2,3,3),imshow(output_mean_img_g);
% title('Mean filtered  Image for gaussian noise', 'FontSize', fontSize);
% Gaussian Filtering
[output_Gaussian_filter_img_g,output_gauss_enhanced_img_g] = Gaussian_filter(gaussian_noise_img, 5,0.8);
% figure(3),subplot(2,3,4),imshow(output_Gaussian_filter_img_g);
% title('Gaussian filtered  Image for Gaussian noise', 'FontSize', fontSize);


% %% Figures
% % Filtering and enhancing salt noised image
figure(1),subplot(2,3,1),imshow(salt_noise_img),title(['salt noised image of variancce',num2str(salt_variance)]);
figure(1),subplot(2,3,2);imshow(output_med_filter_img_s);title('Median filtered  Image for salt noise');
figure(1),subplot(2,3,3);imhist(salt_noise_img);title('Hitogram ofsalt noise image');
figure(1),subplot(2,3,4),imshow(uint8(output_enhanced_img_s));title('Median filtered enahnced Image for salt noise');
figure(1),subplot(2,3,5);imhist(uint8(output_enhanced_img_s));title('Hitogram of Median filtered  Image for salt noise');
%
figure(2),subplot(2,3,1),imshow(salt_noise_img),title(['salt noised image of variancce',num2str(salt_variance)]);
figure(2),subplot(2,3,2);imshow(output_mean_img_s);title('Mean filtered  Image for salt noise');
figure(2),subplot(2,3,3);imhist(salt_noise_img);title('Hitogram of salt noise image');
figure(2),subplot(2,3,4),imshow(uint8(output_mean_enhanced_img_s));title('Mean filtered enahnced Image for salt noise');
figure(2),subplot(2,3,5);imhist(uint8(output_mean_enhanced_img_s));title('Hitogram of Mean filtered  Image for salt noise');
%
figure(3),subplot(2,3,1),imshow(salt_noise_img),title(['salt noised image of variancce',num2str(salt_variance)]);
figure(3),subplot(2,3,2);imshow(output_Gaussian_filter_img_s);title('Gaussian filtered  Image for salt noise');
figure(3),subplot(2,3,3);imhist(salt_noise_img);title('Hitogram of  salt noise image');
figure(3),subplot(2,3,4),imshow(uint8(output_gauss_enhanced_img_s));title('Gaussian filtered enahnced Image for salt noise');
figure(3),subplot(2,3,5);imhist(uint8(output_gauss_enhanced_img_s));title('Hitogram of Gaussian filtered  Image for salt noise');
%

% Filtering and enhancing Gaussian noised image
figure(4),subplot(2,3,1),imshow(gaussian_noise_img),title(['Gaussian noised image of variancce',num2str(gaussian_variance)]);
figure(4),subplot(2,3,2);imshow(output_med_filter_img_g);title('Median filtered  Image for Gaussian noise');
figure(4),subplot(2,3,3);imhist(gaussian_noise_img);title('Hitogram of Gaussian noised image');
figure(4),subplot(2,3,4),imshow(uint8(output_enhanced_img_g));title('Median filtered enahnced Image for Gaussian noise');
figure(4),subplot(2,3,5);imhist(uint8(output_enhanced_img_g));title('Hitogram of Median filtered  Image for Gaussian noise');
%
figure(5),subplot(2,3,1),imshow(gaussian_noise_img),title(['Gaussain noised image of variancce',num2str(gaussian_variance)]);
figure(5),subplot(2,3,2);imshow(output_mean_img_g);title('Mean filtered  Image for Gaussian noise');
figure(5),subplot(2,3,3);imhist(gaussian_noise_img);title('Hitogram of  Gaussian noised image');
figure(5),subplot(2,3,4),imshow(uint8(output_mean_enhanced_img_g));title('Mean filtered enahnced Image for Gaussian noise');
figure(5),subplot(2,3,5);imhist(uint8(output_mean_enhanced_img_g));title('Hitogram of Mean filtered  Image for Gaussian noise');
%
figure(6),subplot(2,3,1),imshow(gaussian_noise_img),title(['Gaussian noised image of variancce',num2str(gaussian_variance)]);
figure(6),subplot(2,3,2);imshow(output_Gaussian_filter_img_g);title('Gaussian filtered  Image for Gaussian');
figure(6),subplot(2,3,3);imhist(gaussian_noise_img);title('Hitogram of  Gaussian noised image');
figure(6),subplot(2,3,4),imshow(uint8(output_gauss_enhanced_img_g));title('Gaussian filtered enahnced Image for Gaussian noise');
figure(6),subplot(2,3,5);imhist(uint8(output_gauss_enhanced_img_g));title('Hitogram of Gaussian filtered  Image for Gaussian noise');
%

%% Calculation of PSNR
PSNR=[];
PSNR(1,:,:) = psnr(output_med_filter_img_s, salt_noise_img);
PSNR(2,:,:) = psnr(output_mean_img_s, salt_noise_img);
PSNR(3,:,:) = psnr(output_Gaussian_filter_img_s, salt_noise_img);
PSNR(4,:,:) = psnr(output_enhanced_img_s, salt_noise_img);
PSNR(5,:,:) = psnr(output_mean_enhanced_img_s, salt_noise_img);
PSNR(6,:,:) = psnr(output_gauss_enhanced_img_s, salt_noise_img);
PSNR(7,:,:) = psnr(output_med_filter_img_g, gaussian_noise_img);
PSNR(8,:,:) = psnr(output_mean_img_g, gaussian_noise_img);
PSNR(9,:,:) = psnr(output_Gaussian_filter_img_g, gaussian_noise_img);
PSNR(10,:,:) = psnr(output_enhanced_img_g, gaussian_noise_img);
PSNR(11,:,:) = psnr(output_mean_enhanced_img_g, gaussian_noise_img);
PSNR(12,:,:) = psnr(output_gauss_enhanced_img_g, gaussian_noise_img);
psnr=[];
%psnr(1)=(PSNR(1,1)+PSNR(1,2)+PSNR(1,3))/3;
for i=1:12
psnr(i)=(PSNR(i,1)+PSNR(i,2)+PSNR(i,3))/3;
end