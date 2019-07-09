% canny_edge_detection.m
%
% Part Of: Project 2
%
% Created By: Matthew Lonis
% Created On: 20 March 2018
% Last Modified By: Matthew Lonis
% Last Modified On: 24 March 2018


function edge_image = canny_edge_detection(input_image, sigma, lowThresh, highThresh)
    input_image = im2single(input_image);

    [gx, gy] = project2_partA(input_image, sigma);
    
    gradient_magnitude_image = project2_partB(gx, gy);

    non_maximum_suppression_image = project2_partC(gradient_magnitude_image);
    
    hysteresis_thresholding_image = project2_partD(non_maximum_suppression_image, lowThresh, highThresh);
    
    edge_image = hysteresis_thresholding_image;
end