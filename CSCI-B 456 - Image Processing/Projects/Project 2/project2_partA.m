% project2_partA.m
%
% Part Of: Project 2
%
% Created By: Matthew Lonis
% Created On: 20 March 2018
% Last Modified By: Matthew Lonis
% Last Modified On: 24 March 2018


function [gx, gy] = project2_partA(input_image, sigma)
    % gaussKernel = fspecial('gauss',[3, 3], sigma); This didn't work out
    % well for me
    
    gaussian_kernel = make_gaussian_kernel(3, sigma);
    
    % dx and dy stand for the derivatives in the x/y direction of
    % gaussian_kernel
    [dx, dy] = gradient(gaussian_kernel);
    
    % gx and gy stand for the convolution of dx and dy with input_image.
    % The intention was to make it look like dx and dy because the
    % convolution is with the Derivative of a Gaussian in the X and Y
    % directions.
    gx = conv2(input_image, dx, 'same');
    gy = conv2(input_image, dy, 'same');
end