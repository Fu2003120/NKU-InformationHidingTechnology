function OverlayGray()

origin = rgb2gray(imread("lena.png"));

origin1 = rgb2gray(imread("Google.png"));

origin2 = rgb2gray(imread("window.png"));

%原图
figure(1);
imshow(origin);
title('原图');

figure(2);
imshow(origin1);
title('分存图1');

figure(3);
imshow(origin2);
title('分存图2');


origin = turn_to_bw(origin);
origin1 = turn_to_bw(origin1);
origin2 = turn_to_bw(origin2);

%半色调化后的图像
figure(4);
imshow(origin);
title('半色调化后的原图');

figure(5);
imshow(origin1);
title('半色调化后的分存图1');

figure(6);
imshow(origin2);
title('半色调化后的分存图2');


[image1,image2] = divide(origin,origin1,origin2);
figure(7);
imshow(image1);
title('伪装图像1');
figure(8);
imshow(image2);
title('伪装图像2');
originB = merge(image1,image2);
figure(9);
imshow(originB);
title('恢复后的图像');
end


function image = turn_to_bw(gray)
Size=size(gray);
x=Size(1);
y=Size(2);

for m=1:x
    for n=1:y
        if gray(m,n)>127
            out=255;
        else
            out=0;
        end
        error=gray(m,n)-out;
        if n>1 && n<255 && m<255
            gray(m,n+1)=gray(m,n+1)+error*7/16.0;  %右方
            gray(m+1,n)=gray(m+1,n)+error*5/16.0;  %下方
            gray(m+1,n-1)=gray(m+1,n-1)+error*3/16.0;  %左下方
            gray(m+1,n+1)=gray(m+1,n+1)+error*1/16.0;  %右下方
            gray(m,n)=out;
        else
            gray(m,n)=out;
        end
    end
end
image=gray;

end



function [image1,image2] = divide(origin,origin1,origin2)
%init
Size=size(origin);
x=Size(1);
y=Size(2);
image1=zeros(2*x,2*y);
image1(:,:)=255;
image2=zeros(2*x,2*y);
image2(:,:)=255;

%take image1 as first
for i = 1:x
    for j = 1:y
        key = randi(4);
        son_x=1+2*(i-1);
        son_y=1+2*(j-1);
        switch key
            case 1
                if origin(i,j)==0 && origin1(i,j)==0 && origin2(i,j)==0  %黑  黑  黑
                    image1(son_x,son_y)=0;
                    image1(son_x+1,son_y)=0;
                    image1(son_x+1,son_y+1)=0;

                    image2(son_x,son_y+1)=0;
                    image2(son_x+1,son_y)=0;
                    image2(son_x+1,son_y+1)=0;
                
                elseif origin(i,j)==0 && origin1(i,j)==0 && origin2(i,j)~=0  %黑 黑 白
                    image1(son_x,son_y+1)=0;
                    image1(son_x+1,son_y)=0;
                    image1(son_x+1,son_y+1)=0;

                    image2(son_x,son_y)=0;
                    image2(son_x,son_y+1)=0;

                elseif origin(i,j)==0 && origin1(i,j)~=0 && origin2(i,j)==0  %黑 白 黑
                    image1(son_x+1,son_y)=0;
                    image1(son_x+1,son_y+1)=0;

                    image2(son_x,son_y)=0;
                    image2(son_x,son_y+1)=0;
                    image2(son_x+1,son_y)=0;
                
                elseif origin(i,j)==0 && origin1(i,j)~=0 && origin2(i,j)~=0  %黑 白 白
                    image1(son_x+1,son_y)=0;
                    image1(son_x+1,son_y+1)=0;

                    image2(son_x,son_y)=0;
                    image2(son_x,son_y+1)=0;

                elseif origin(i,j)~=0 && origin1(i,j)==0 && origin2(i,j)==0  %白 黑 黑
                    image1(son_x,son_y)=0;
                    image1(son_x,son_y+1)=0;
                    image1(son_x+1,son_y)=0;

                    image2(son_x,son_y)=0;
                    image2(son_x,son_y+1)=0;
                    image2(son_x+1,son_y)=0;

                elseif origin(i,j)~=0 && origin1(i,j)==0 && origin2(i,j)~=0  %白 黑 白
                    image1(son_x,son_y)=0;
                    image1(son_x,son_y+1)=0;
                    image1(son_x+1,son_y)=0;

                    image2(son_x,son_y)=0;
                    image2(son_x,son_y+1)=0;

                elseif origin(i,j)~=0 && origin1(i,j)~=0 && origin2(i,j)~=0  %白 白 白
                    image1(son_x,son_y+1)=0;
                    image1(son_x+1,son_y+1)=0;

                    image2(son_x,son_y)=0;
                    image2(son_x,son_y+1)=0;

                elseif origin(i,j)~=0 && origin1(i,j)~=0 && origin2(i,j)==0  %白 白 黑
                    image1(son_x+1,son_y)=0;
                    image1(son_x+1,son_y+1)=0;

                    image2(son_x,son_y+1)=0;
                    image2(son_x+1,son_y)=0;
                    image2(son_x+1,son_y+1)=0;
                
                end
            case 2
                if origin(i,j)==0 && origin1(i,j)==0 && origin2(i,j)==0  %黑  黑  黑
                    image1(son_x,son_y)=0;
                    image1(son_x,son_y+1)=0;
                    image1(son_x+1,son_y)=0;

                    image2(son_x,son_y)=0;
                    image2(son_x,son_y+1)=0;
                    image2(son_x+1,son_y+1)=0;
                
                elseif origin(i,j)==0 && origin1(i,j)==0 && origin2(i,j)~=0  %黑 黑 白
                    image1(son_x,son_y)=0;
                    image1(son_x+1,son_y)=0;
                    image1(son_x+1,son_y+1)=0;

                    image2(son_x,son_y+1)=0;
                    image2(son_x+1,son_y+1)=0;

                elseif origin(i,j)==0 && origin1(i,j)~=0 && origin2(i,j)==0  %黑 白 黑
                    image1(son_x,son_y)=0;
                    image1(son_x+1,son_y)=0;

                    image2(son_x,son_y+1)=0;
                    image2(son_x+1,son_y)=0;
                    image2(son_x+1,son_y+1)=0;
                
                elseif origin(i,j)==0 && origin1(i,j)~=0 && origin2(i,j)~=0  %黑 白 白
                    image1(son_x,son_y)=0;
                    image1(son_x+1,son_y)=0;

                    image2(son_x,son_y+1)=0;
                    image2(son_x+1,son_y+1)=0;

                elseif origin(i,j)~=0 && origin1(i,j)==0 && origin2(i,j)==0  %白 黑 黑
                    image1(son_x,son_y)=0;
                    image1(son_x,son_y+1)=0;
                    image1(son_x+1,son_y+1)=0;

                    image2(son_x,son_y)=0;
                    image2(son_x,son_y+1)=0;
                    image2(son_x+1,son_y+1)=0;

                elseif origin(i,j)~=0 && origin1(i,j)==0 && origin2(i,j)~=0  %白 黑 白
                    image1(son_x,son_y)=0;
                    image1(son_x,son_y+1)=0;
                    image1(son_x+1,son_y+1)=0;

                    image2(son_x,son_y)=0;
                    image2(son_x+1,son_y+1)=0;

                elseif origin(i,j)~=0 && origin1(i,j)~=0 && origin2(i,j)~=0  %白 白 白
                    image1(son_x,son_y)=0;
                    image1(son_x,son_y+1)=0;

                    image2(son_x,son_y)=0;
                    image2(son_x+1,son_y+1)=0;

                elseif origin(i,j)~=0 && origin1(i,j)~=0 && origin2(i,j)==0  %白 白 黑
                    image1(son_x,son_y)=0;
                    image1(son_x,son_y+1)=0;

                    image2(son_x,son_y)=0;
                    image2(son_x,son_y+1)=0;
                    image2(son_x+1,son_y+1)=0;
                
                end
                
            case 3
                if origin(i,j)==0 && origin1(i,j)==0 && origin2(i,j)==0  %黑  黑  黑
                    image1(son_x,son_y+1)=0;
                    image1(son_x+1,son_y)=0;
                    image1(son_x+1,son_y+1)=0;

                    image2(son_x,son_y)=0;
                    image2(son_x+1,son_y)=0;
                    image2(son_x+1,son_y+1)=0;
                
                elseif origin(i,j)==0 && origin1(i,j)==0 && origin2(i,j)~=0  %黑 黑 白
                    image1(son_x,son_y)=0;
                    image1(son_x,son_y+1)=0;
                    image1(son_x+1,son_y+1)=0;

                    image2(son_x+1,son_y)=0;
                    image2(son_x+1,son_y+1)=0;

                elseif origin(i,j)==0 && origin1(i,j)~=0 && origin2(i,j)==0  %黑 白 黑
                    image1(son_x,son_y)=0;
                    image1(son_x,son_y+1)=0;

                    image2(son_x,son_y)=0;
                    image2(son_x+1,son_y)=0;
                    image2(son_x+1,son_y+1)=0;
                
                elseif origin(i,j)==0 && origin1(i,j)~=0 && origin2(i,j)~=0  %黑 白 白
                    image1(son_x,son_y)=0;
                    image1(son_x,son_y+1)=0;

                    image2(son_x+1,son_y)=0;
                    image2(son_x+1,son_y+1)=0;

                elseif origin(i,j)~=0 && origin1(i,j)==0 && origin2(i,j)==0  %白 黑 黑
                    image1(son_x,son_y+1)=0;
                    image1(son_x+1,son_y)=0;
                    image1(son_x+1,son_y+1)=0;

                    image2(son_x,son_y+1)=0;
                    image2(son_x+1,son_y)=0;
                    image2(son_x+1,son_y+1)=0;

                elseif origin(i,j)~=0 && origin1(i,j)==0 && origin2(i,j)~=0  %白 黑 白
                    image1(son_x,son_y)=0;
                    image1(son_x+1,son_y)=0;
                    image1(son_x+1,son_y+1)=0;

                    image2(son_x+1,son_y)=0;
                    image2(son_x+1,son_y+1)=0;

                elseif origin(i,j)~=0 && origin1(i,j)~=0 && origin2(i,j)~=0  %白 白 白
                    image1(son_x,son_y+1)=0;
                    image1(son_x+1,son_y)=0;

                    image2(son_x+1,son_y)=0;
                    image2(son_x+1,son_y+1)=0;

                elseif origin(i,j)~=0 && origin1(i,j)~=0 && origin2(i,j)==0  %白 白 黑
                    image1(son_x,son_y+1)=0;
                    image1(son_x+1,son_y)=0;

                    image2(son_x,son_y)=0;
                    image2(son_x,son_y+1)=0;
                    image2(son_x+1,son_y)=0;
                
                end
                
            case 4
                if origin(i,j)==0 && origin1(i,j)==0 && origin2(i,j)==0  %黑  黑  黑
                    image1(son_x,son_y)=0;
                    image1(son_x,son_y+1)=0;
                    image1(son_x+1,son_y+1)=0;

                    image2(son_x,son_y)=0;
                    image2(son_x,son_y+1)=0;
                    image2(son_x+1,son_y)=0;
                
                elseif origin(i,j)==0 && origin1(i,j)==0 && origin2(i,j)~=0  %黑 黑 白
                    image1(son_x,son_y)=0;
                    image1(son_x,son_y+1)=0;
                    image1(son_x+1,son_y)=0;

                    image2(son_x,son_y)=0;
                    image2(son_x+1,son_y+1)=0;

                elseif origin(i,j)==0 && origin1(i,j)~=0 && origin2(i,j)==0  %黑 白 黑
                    image1(son_x,son_y+1)=0;
                    image1(son_x+1,son_y)=0;

                    image2(son_x,son_y)=0;
                    image2(son_x,son_y+1)=0;
                    image2(son_x+1,son_y+1)=0;
                
                elseif origin(i,j)==0 && origin1(i,j)~=0 && origin2(i,j)~=0  %黑 白 白
                    image1(son_x,son_y+1)=0;
                    image1(son_x+1,son_y)=0;

                    image2(son_x,son_y)=0;
                    image2(son_x+1,son_y+1)=0;

                elseif origin(i,j)~=0 && origin1(i,j)==0 && origin2(i,j)==0  %白 黑 黑
                    image1(son_x,son_y)=0;
                    image1(son_x+1,son_y)=0;
                    image1(son_x+1,son_y+1)=0;

                    image2(son_x,son_y)=0;
                    image2(son_x+1,son_y)=0;
                    image2(son_x+1,son_y+1)=0;

                elseif origin(i,j)~=0 && origin1(i,j)==0 && origin2(i,j)~=0  %白 黑 白
                    image1(son_x,son_y+1)=0;
                    image1(son_x+1,son_y)=0;
                    image1(son_x+1,son_y+1)=0;

                    image2(son_x,son_y+1)=0;
                    image2(son_x+1,son_y+1)=0;

                elseif origin(i,j)~=0 && origin1(i,j)~=0 && origin2(i,j)~=0  %白 白 白
                    image1(son_x+1,son_y)=0;
                    image1(son_x+1,son_y+1)=0;

                    image2(son_x,son_y+1)=0;
                    image2(son_x+1,son_y+1)=0;

                elseif origin(i,j)~=0 && origin1(i,j)~=0 && origin2(i,j)==0  %白 白 黑
                    image1(son_x+1,son_y)=0;
                    image1(son_x+1,son_y+1)=0;

                    image2(son_x,son_y)=0;
                    image2(son_x+1,son_y)=0;
                    image2(son_x+1,son_y+1)=0;
                
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