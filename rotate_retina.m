clc; clear all; close all;
I= imread('27.ppm');
size(I)
[R,C,K]= size(I)
I2 = uint8(zeros(round(R*1.5),round(C*1.2),K)); %Image size being enlarged so that ...
                                           ...whole rotated image can be diplayed 
%I2=uint8(zeros(size(I)));
angle=input('Enter the angle with which image to be rotated:');
tic;
rads=2*pi*angle/360;  

% center 
xo=ceil(R/2);                                                            
yo=ceil(C/2);

midx=ceil((size(I2,1))/2);
midy=ceil((size(I2,2))/2);

% calculate corresponding coordinates of pixel of A 

for i=1:round(R*1.5)
    for j=1:round(C*1.2)                                                       

         x= (i-midx)*cos(rads)+(j-midy)*sin(rads);     %Anticlockwise rotation                                  
         y= -(i-midx)*sin(rads)+(j-midy)*cos(rads);   
         a=x-floor(x);
         b=y-floor(y);
         
         x=round(x)+xo;
         y=round(y)+yo;
        %Bilnear interpolation
         if (x>=1 && y>=1 && x+1<=size(I,1) &&  y+1<=size(I,2) ) 
             I2(i,j,:)= ((1-a)*(1-b)*I(floor(x),floor(y),:))+(a*(1-b)*I(floor(x+1),floor(y),:))+ ...
             (b*(1-a)*I(floor(x),floor(y+1),:))+(a*b*I(floor(x+1),floor(y+1),:)); 
         end
%           

    end
end
toc;
I3=imrotate(I,angle);
figure,subplot(1,3,1),imshow(I);axis on;title('original retinal image');

subplot(1,3,2),imshow(I2);axis on;title(['rotated retinal image with angle of rotation:',num2str(angle)]);
subplot(1,3,3),imshow(I3);axis on;title('rotated retinal image using inbuilt')


