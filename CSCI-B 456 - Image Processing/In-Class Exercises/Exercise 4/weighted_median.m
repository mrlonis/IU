% weighted_median.m
%
% Part Of: In-Class Exercise 4
%
% Created By: Matthew Lonis
% Created On: 8 February 2018
% Last Modified By: Matthew Lonis
% Last Modified On: 10 February 2018
%
% Assumptions: array & weighted_array are of the same size

function median = weighted_median(array, weighted_array)
    array_size = size(array);
    sum_val = sum(weighted_array);
    
    temp = zeros([1 sum_val]);
    
    count = 1;
    for i = 1:array_size(1)
        for j = 1:weighted_array(i)
            temp(count) = array(i);
            count = count + 1;
        end
    end
    
    temp = sort(temp);
    temp_size = size(temp);
    
    if (mod(temp_size(2), 2) == 0)
        median1 = temp_size(2) / 2;
        median2 = median1 + 1;
        median = (temp(median1) + temp(median2)) / 2;
    else
        median = temp(ceil(temp_size(2) / 2));
    end
end