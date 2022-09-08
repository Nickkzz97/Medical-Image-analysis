clc; clear all; close all;
I= imread('27.ppm');
%size(I)
[R,C,K]= size(I)
I2=uint8(zeros(size(I)));
r=input('Enter the factor by which image to be resized:');
k=r;
%[f1,f2]=[Ix*0.8,Iy*0.8]
I2 = uint8(zeros(round(R*r),round(C*r),K));
tic;
for x=1:round (R*r)
    for y=1:round(C*r)
       Xs=x/r;
       Ys=y/r;
        a=Xs-floor(Xs);
        b=Ys-floor(Ys);
        %b= y-Ys;
        if Xs>=1 && Ys>=1 && Xs+1 <=  (R) && Ys+1 <=  (C)
        I2(x,y,:)=(1-a)*(1-b)*I(floor(Xs),floor(Ys),:)+(1-a)*b *I(floor(Xs),floor(Ys)+1,:)+(a)*(1-b)*I(floor(Xs)+1,floor(Ys),:)+(a)*(b)*I(floor(Xs)+1,floor(Ys)+1,:);
        end
    %end
    end
end
toc;
I3=imresize(I,r);
figure,subplot(1,3,1),imshow(I);axis on;title('original retinal image');

subplot(1,3,2),imshow(I2);axis on;title(['resized retinal image with factor of :',num2str(r)]);
subplot(1,3,3),imshow(I3);axis on;title('resized retinal image using inbuilt')