% rle_zeros.m
%
% Created By: Matthew Lonis
% Created On: March 31, 2018
% Last Modified By: Matthew Lonis
% Last Modified On: April 24, 2018
%
% Part Of: Final Project
function rle_array = rle_zeros(vector)
    rle_array_temp = zeros(1, (62 * 2 + 2));
    
    vector_size = size(vector);
    
    if (vector_size(1) ~= 1)
        disp("rle_zeros: Error! Vector isn't a 1D vector!");
    else
        rle_array_temp(1) = vector(1);
        i = 2;
        j = 2;
        
       while i <= vector_size(2)
           if (vector(i) ~= 0 ) 
               rle_array_temp(j) = vector(i);
               i = i + 1;
               j = j + 1;
           else
               i = i + 1;
               count = 1;
               
               while i <= vector_size(2) && vector(i) == 0
                   i = i + 1;
                   count = count + 1;
               end
               
               rle_array_temp(j) = 0;
               rle_array_temp(j + 1) = count;
               j = j + 2;
           end
       end
        
       rle_array_temp(j) = 0; 
       rle_array_temp(j + 1) = 0;
       rle_array = rle_array_temp(1:j+1);
    end
end