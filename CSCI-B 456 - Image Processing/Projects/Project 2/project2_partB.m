% project2_partB.m
%
% Part Of: Project 2
%
% Created By: Matthew Lonis
% Created On: 20 March 2018
% Last Modified By: Matthew Lonis
% Last Modified On: 24 March 2018


function gradient_magnitude_image = project2_partB(gx, gy)
    magnitude = (gx .^ 2) + (gy .^ 2);
    gradient_magnitude_image = sqrt(magnitude);
end