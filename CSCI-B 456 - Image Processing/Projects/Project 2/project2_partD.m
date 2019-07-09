% project2_partD.m
%
% Part Of: Project 2
%
% Created By: Matthew Lonis
% Created On: 20 March 2018
% Last Modified By: Matthew Lonis
% Last Modified On: 24 March 2018


function hysteresis_thresholding_image = project2_partD(non_maximum_suppression_image, lowThresh, highThresh)
    [row, col] = size(non_maximum_suppression_image);

    hysteresis_thresholding_image = zeros(row, col);

    for i = 1 : row
        for j = 1 : col
            if (non_maximum_suppression_image(i, j) < lowThresh)
                hysteresis_thresholding_image(i, j) = 0;
            elseif (non_maximum_suppression_image(i, j) > highThresh)
                hysteresis_thresholding_image(i, j) = 1;
            % Checking if the element connects to an element in the upper
            % threshold by 8-ways
            elseif (non_maximum_suppression_image(i + 1, j) > highThresh ...
                    || non_maximum_suppression_image(i - 1, j) > highThresh ...
                    || non_maximum_suppression_image(i, j + 1) > highThresh ...
                    || non_maximum_suppression_image(i, j - 1) > highThresh ...
                    || non_maximum_suppression_image(i - 1, j - 1) > highThresh ...
                    || non_maximum_suppression_image(i - 1, j + 1) > highThresh ...
                    || non_maximum_suppression_image(i + 1, j + 1) > highThresh ...
                    || non_maximum_suppression_image(i + 1, j - 1) > highThresh)
                hysteresis_thresholding_image(i,j) = 1;
            end
        end
    end

    hysteresis_thresholding_image = uint8(hysteresis_thresholding_image .* 255);
end