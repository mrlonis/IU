% project2_partC.m
%
% Part Of: Project 2
%
% Created By: Matthew Lonis
% Created On: 20 March 2018
% Last Modified By: Matthew Lonis
% Last Modified On: 24 March 2018

function non_maximum_suppression_image = project2_partC(gradient_magnitude_image)
    [row, col] = size(gradient_magnitude_image);
    
    non_maximum_suppression_image = false(row, col);

    % We don't consider the edge pixels. Hence why we start at 2 and end at
    % row - 1 and col - 1
    for i = 2 : row - 1
        for j = 2 : col - 1
            % I didn't know how to do this based off the PowerPoint
            % provided to us so I just checked if each element was a max of
            % its right and bottom element (as well as itself)
            non_maximum_suppression_image(i, j) = (gradient_magnitude_image(i, j) ...
                == max([gradient_magnitude_image(i, j), ...
                gradient_magnitude_image(i, j + 1), ...
                gradient_magnitude_image(i + 1, j)]));
        end
    end
    
    non_maximum_suppression_image = non_maximum_suppression_image .* gradient_magnitude_image;
end