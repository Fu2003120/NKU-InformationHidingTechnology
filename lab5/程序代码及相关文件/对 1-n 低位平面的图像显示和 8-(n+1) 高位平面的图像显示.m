img = imread("Lena.bmp");
k = input("Please enter the value of n: ");
[a, b] = size(img);
y = zeros(a, b);
z = zeros(a, b);

for n = 1:k
    for i = 1:a
        for j = 1:b
            x(i, j) = bitget(img(i, j), n);
        end
    end
    for i = 1:a
        for j = 1:b
            y(i, j) = bitset(y(i, j), n, x(i, j));
        end
    end
end

for n = k+1:8
    for i = 1:a
        for j = 1:b
            x(i, j) = bitget(img(i, j), n);
        end
    end
    for i = 1:a
        for j = 1:b
            z(i, j) = bitset(z(i, j), n, x(i, j));
        end
    end
end

figure;
subplot(1, 2, 1); % 1 row, 2 columns, 1st subplot
imshow(y, []);
title(['Bit planes 1-', num2str(k)]);
subplot(1, 2, 2); % 1 row, 2 columns, 2nd subplot
imshow(z, []);
title(['Bit planes ', num2str(k+1), '-8']);
exportgraphics(gcf, 'bit_planes_decomposition.png');