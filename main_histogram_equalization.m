%%Histogram equalisqation
clc; clear all; close all;
I= imread('27.ppm');
size(I)
[R,C,K]= size(I)
x = 0 :1: 255;
histogram1=im_histogram(I);
figure(3),subplot(2,3,1),bar(x, histogram1(x+1), 'BarWidth', 0.8),title('input image histogram using im_histogram');
%%
%%Equalize histogram with RGB channel separately
[R_equalized_img,R_equalized] = equalize_hist(I(:,:,1));
[G_equalized_img,G_equalized] = equalize_hist(I(:,:,2));
[B_equalized_img,B_equalized] = equalize_hist(I(:,:,3));
rebuild_rgb_img = cat(3, R_equalized_img, G_equalized_img, B_equalized_img);

figure(1),subplot(2,3,2), imshow(rebuild_rgb_img), title('Equalize histogram with RGB channel separately');
figure(2),subplot(2,3,2), imhist(rebuild_rgb_img), title('Equalize histogram with RGB channel separately');
histogram2=im_histogram(rebuild_rgb_img); % Histogram plot function
figure(3),subplot(2,3,2),bar(x, histogram2(x+1), 'BarWidth', 0.8);title('Equalize histogram with RGB channel separately');
%% Equalize histogram with average of RGB channel and computing histogram using im_histogram function
[RGB_hist_img,histogram3] = rgb_average_histogram(I);
figure(1),subplot(2,3,3), imshow(RGB_hist_img), title('Equalize histogram with average of RGB channel');


figure(3),subplot(2,3,3),bar(x, histogram3(x+1), 'BarWidth', 0.8);title('Equalize histogram with average of RGB channel');
figure(2),subplot(2,3,3),imhist(RGB_hist_img);title('Equalize histogram with average of RGB channel');
%%Equalize histogram only with intensity value

HSI_hist_img = HSI_hist(I);
figure(1),subplot(2,3,4), imshow(HSI_hist_img), title('HSI hist img');
figure(2),subplot(2,3,4), imhist(HSI_hist_img), title('HSI hist img');
histogram4=im_histogram(rebuild_rgb_img);
figure(3),subplot(2,3,4),bar(x, histogram4(x+1), 'BarWidth', 0.8);title('HSI hist img');
%%
%CONVERT THE RGB IMAGE INTO HSV IMAGE FORMAT
HSV = rgb2hsv(I);
%PERFORM HISTOGRAM EQUALIZATION ON INTENSITY COMPONENT using inbuilt
Heq = histeq(HSV(:,:,3));
HSV_mod = HSV;
HSV_mod(:,:,3) = Heq;
RGB = hsv2rgb(HSV_mod);
RGB = im2uint8(RGB);
figure(1),subplot(2,3,1),imshow(I);title('Before Histogram Equalization');
figure(2),subplot(2,3,1),imhist(I);title('Before Histogram Equalization');
figure(1),subplot(2,3,5),imshow(RGB);title('Intensity Histogram Equalization using inbuilt histeq');
figure(2),subplot(2,3,5),imhist(RGB);title('Intensity Histogram Equalization using inbuilt histeq');
histogram5=im_histogram(RGB);
figure(3),subplot(2,3,5),bar(x, histogram5(x+1), 'BarWidth', 0.8);title('HSI hist img');
%%



J=histeq(I);
figure(1),subplot(2,3,6),imshow(J),title('Histogram Equalization using inbuilt histeq');
figure(2),subplot(2,3,6),imhist(J);title('Histogram Equalization using inbuilt histeq');
histogram6=im_histogram(J);
figure(3),subplot(2,3,6),bar(x, histogram6(x+1), 'BarWidth', 0.8);title('Histogram Equalization using inbuilt histeq');
%%

% C=fn_CLAHE(I);
% figure(4),imshow(C),title('Histogram Equalization using CLAHE');
% CEImage= runCLAHE(I,605,700,0,255,4,4,64,8);
% figure(5),imshow(CEImage),title('Histogram Equalization using CLAHE');