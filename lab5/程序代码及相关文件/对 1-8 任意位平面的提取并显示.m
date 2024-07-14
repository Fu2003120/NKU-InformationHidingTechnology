img = imread("Lena.bmp"); % Read the image file
[m, n] = size(img); % Get the image dimensions
figure('Position', [100, 100, 1200, 800]); % Create a new large image window
for k = 1:8 % Loop to display images of eight bit planes
    c = zeros(m, n); % Create a zero matrix the same size as the image
    % Iterate over each pixel of the image
    for i = 1:m
        for j = 1:n
            c(i, j) = bitget(img(i, j), k); % Extract pixel information from the kth bit plane
        end
    end
    % Place images of eight bit planes in a subplot and adjust the size of the subplot
    subplot(2, 4, k);
    pos = get(gca, 'Position');
    pos(3:4) = [0.2 0.2]; % Adjust the size of the subplot
    set(gca, 'Position', pos);
    imshow(c, []);
    title(['Bit Plane ', num2str(k)]); % Set the title of the subplot
end
saveas(gcf, 'Images_of_Eight_Bit_Planes.png');