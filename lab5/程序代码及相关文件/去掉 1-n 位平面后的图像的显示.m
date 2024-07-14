img = imread("Lena.bmp"); % Load the image
[a, b] = size(img); % Get the size of the image
figure; % Create a figure for all subplots
for n = 1:8 % Automatically iterate through the first 8 bit planes
    modifiedImg = img; % Copy the original image for modification
    for i = 1:a
        for j = 1:b
            modifiedImg(i, j) = bitset(modifiedImg(i, j), n, 0); % Set the nth bit to 0
        end
    end
    subplot(2, 4, n); % Arrange the subplots in 2 rows and 4 columns
    imshow(modifiedImg, []); % Display the modified image
    title(['Remove ', num2str(n), ' bit']); % Use English for title
end
saveas(gcf, 'modified_image_subplot_2x4.png');