% image_segmentation.m
%
% Part Of: In-Class Exercise 8
%
% Created By: Matthew Lonis
% Created On: 1 April 2018
% Last Modified By: Matthew Lonis
% Last Modified On: 3 April 2018
%
% Description:
%       This code if based off of the MATLAB's description for color-image
%       segmentation using K-means clustering found at
%       https://www.mathworks.com/help/images/examples/color-based-segmentation-using-k-means-clustering.html
%
%       This function uses a function called kmeans found in the MATLAB
%       Statistics and Machine Learning Toolbox of Functions. No part of
%       the assignment instructions said functions like these are not
%       allowed.
function [output_image] = image_segmentation(input_image, k)
    % Convert to double b/c I like doubles
    double_input_image = im2double(input_image);

    % Convert double_input_image into an array of pixel values where each
    % row is the r, g, b double values and the number of columns is the
    % width of the image multiplied by the height of the image
    row = size(double_input_image, 1);
    col = size(double_input_image, 2);
    input_image_1x3D_Array = reshape(double_input_image, [row * col, 3]);

    % Find the kmeans clusters
    [cluster_idx, cluster_center] = kmeans(input_image_1x3D_Array, k, 'distance', 'sqEuclidean', 'Replicates', 3);

    % Reshape cluster_idx into the original X x Y x ColorSpace Matrix
    pixel_labels = reshape(cluster_idx, row, col);
    
    % Set output_image
    output_image = double_input_image;
    
    % Loop through output_image, find what group each pixel belongs to, and
    % set its color value to the cluster_center value obtained from the
    % kmeans function.
    for x = 1:row
        for y = 1:col
            group_num = pixel_labels(x, y);
            output_image(x, y, 1) = cluster_center(group_num, 1);
            output_image(x, y, 2) = cluster_center(group_num, 2);
            output_image(x, y, 3) = cluster_center(group_num, 3);
        end
    end
end