function VisualCryptographyBin()
origin = im2bw(imread("lena.png"));

[image1,image2] = divide(origin);
figure;
imshow(origin);
title('二值图像');
%% 
figure;
imshow(image1);
title('伪装图像1');
%% 
figure;
imshow(image2);
title('伪装图像2');
%%
origin1 = merge(image1,image2);
figure;
imshow(origin1);
title('恢复后图像');
end

function [image1,image2] = divide(image)
%init
Size=size(image);
x=Size(1);
y=Size(2);
image1=zeros(2*x,2*y);
image1(:,:)=255;
image2=zeros(2*x,2*y);
image2(:,:)=255;

%take image1 as first
for i = 1:x
    for j = 1:y
        key = randi(3);
        son_x=1+2*(i-1);
        son_y=1+2*(j-1);
        switch key
            case 1
                image1(son_x,son_y)=0; image1(son_x,son_y+1)=0;
                if image(i,j)==0
                    %origin is black
                    image2(son_x+1,son_y)=0; image2(son_x+1,son_y+1)=0;
                else
                    %origin is white
                    image2(son_x,son_y+1)=0; image2(son_x+1,son_y+1)=0;
                end
            case 2
                image1(son_x,son_y)=0; image1(son_x+1,son_y+1)=0;
                if image(i,j)==0
                    %origin is black
                    image2(son_x,son_y+1)=0; image2(son_x+1,son_y)=0;
                else
                    %origin is white
                    image2(son_x,son_y)=0; image2(son_x+1,son_y)=0;
                end
            case 3
                image1(son_x,son_y)=0; image1(son_x+1,son_y)=0;
                if image(i,j)==0
                    %origin is black
                    image2(son_x,son_y+1)=0; image2(son_x+1,son_y+1)=0;
                else
                    %origin is white
                    image2(son_x,son_y)=0; image2(son_x,son_y+1)=0;
                end
        end
    end
end

end


function image = merge(image1,image2)
Size=size(image1);
x=Size(1);
y=Size(2);
image=zeros(x,y);
image(:,:)=255;

for i=1:x
    for j=1:y
        image(i,j)=image1(i,j)&image2(i,j);
    end
end

end