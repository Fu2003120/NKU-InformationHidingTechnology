function knVisualCryptography(k,n)
    origin = im2bw(imread("lena.png"));

    sharedImages = divide(origin, n);
    
    selectedShares = datasample(1:n, k, 'Replace', false);
    selectedImages = sharedImages(selectedShares);

    recoveredImage = merge(selectedImages);

    figure;
    imshow(origin);
    title('原始二值图像');

    for i = 1:n
        figure;
        imshow(sharedImages{i});
        title(['分存图像', num2str(i)]);
    end

    figure;
    imshow(recoveredImage);
    title('恢复后图像');
end

function sharedImages = divide(image, n)
    Size = size(image);
    x = Size(1);
    y = Size(2);
    
    sharedImages = cell(1, n);
    
    for idx = 1:n
        sharedImages{idx} = zeros(2*x, 2*y);
    end

    for i = 1:x
        for j = 1:y
            value = image(i, j);
            for idx = 1:n
                key = randi(3);
                switch key
                    case 1
                        sharedImages{idx}(2*i-1, 2*j-1) = value;
                        sharedImages{idx}(2*i-1, 2*j) = ~value;
                        sharedImages{idx}(2*i, 2*j-1) = ~value;
                        sharedImages{idx}(2*i, 2*j) = value;
                    case 2
                        sharedImages{idx}(2*i-1, 2*j-1) = value;
                        sharedImages{idx}(2*i-1, 2*j) = ~value;
                        sharedImages{idx}(2*i, 2*j-1) = value;
                        sharedImages{idx}(2*i, 2*j) = ~value;
                    case 3
                        sharedImages{idx}(2*i-1, 2*j-1) = ~value;
                        sharedImages{idx}(2*i-1, 2*j) = value;
                        sharedImages{idx}(2*i, 2*j-1) = ~value;
                        sharedImages{idx}(2*i, 2*j) = value;
                end
            end
        end
    end
end

function image = merge(images)
    Size = size(images{1});
    x = Size(1) / 2;
    y = Size(2) / 2;
    image = zeros(x, y);

    for i = 1:x
        for j = 1:y
            pixelValues = cellfun(@(img) img(2*i-1,2*j-1), images);
            count_0 = sum(pixelValues == 0);
            count_1 = sum(pixelValues == 1);
            if count_0 > count_1
                image(i,j) = 0;
            else
                image(i,j) = 1;
            end
        end
    end
end
