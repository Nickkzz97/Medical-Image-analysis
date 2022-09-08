clc; clear all; close all;
I= imread('27.ppm');
size(I)
[R,C,K]= size(I)
I2=uint8(zeros(size(I)));
%figure,imshow(I2)
tx=input('enter the value x_sift to be performed:');
ty=input('enter the value of y_shift to be performed:');
%tx=4.5; ty=3.4;
tic;
a=tx-floor(tx); b=ty-floor(ty);
for x=1:R
    for y=1:C
        Xs=x-floor(ty);
        Ys=y-floor(tx);
        %b= y-Ys;
        %if (Xs<1)||(Ys<1)||(Xs>R)||(Ys>C)
        %  I2(x,y)=0;
        if Xs>=1 && Ys>=1 && Xs <= R && Ys <= C
        %else
            I2(x,y,:)=(1-a)*(1-b)*I(Xs,Ys,:)+(1-a)*(b) *I(Xs,Ys+1,:)+(a)*(1-b)*I(Xs+1,Ys,:)+(a)*(b)*I(Xs+1,Ys+1,:);%Bilinear Interpolation
             
        end
    end
end
toc;
I3=imtranslate(I,[tx,ty]);
figure,subplot(1,3,1),imshow(I);axis on;title('original retinal image');

subplot(1,3,2),imshow(I2);axis on;title(['translated retinal image with tx: ',num2str(tx), 'and ty : ',num2str(ty)]);
subplot(1,3,3),imshow(I3);axis on;title('translated retinal image using inbuilt')
