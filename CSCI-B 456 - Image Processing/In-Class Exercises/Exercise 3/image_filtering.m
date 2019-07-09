% image_filtering.m
%
% Part Of: In-Class Exercise 3
%
% Created By: Matthew Lonis
% Created On: 2 February 2018
% Last Modified By: Matthew Lonis
% Last Modified On: 6 February 2018

function [output_image] = image_filtering(input_image, kernel_input, boundary_choice)
    input_image_size = size(input_image);
    filtered_image = zeros(input_image_size, 'double');
    kernel_size = size(kernel_input);
    % disp(kernel_size);
    
    offset = floor(kernel_size(1)/2);
    
    padded_matrix = zeros((input_image_size(1) + (kernel_size(1)-1)), (input_image_size(2)+(kernel_size(2)-1)), 'double');
    padded_matrix_size = size(padded_matrix);
    
    startrow = uint16(offset + 1);
    startcol = uint16(offset + 1);
    endrow = uint16(startrow) + uint16(input_image_size(1)) - uint16(1);
    endcol = uint16(startcol) + uint16(input_image_size(2)) - uint16(1);
    
    for loop1 = startrow:endrow
        for loop2 = startcol:endcol
            padded_matrix(loop1, loop2) = input_image(loop1 - offset, loop2 - offset);
        end
    end
    
    % disp('image_filtering: Zero Padding Completed!');
    
    % Edit diagonal values not determined by boundary choice
    for i = 1:offset
        for j = 1:offset
            padded_matrix(i, j) = 1;
        end
    end

    for i = 1:offset
        for j = (padded_matrix_size(2) - offset + 1):padded_matrix_size(2)
            padded_matrix(i, j) = 1;
        end
    end

    for i = (padded_matrix_size(1) - offset + 1):padded_matrix_size(1)
        for j = 1:offset
            padded_matrix(i, j) = 1;
        end
    end

    for i = (padded_matrix_size(1) - offset + 1):padded_matrix_size(1)
        for j = (padded_matrix_size(2) - offset + 1):padded_matrix_size(2)
            padded_matrix(i, j) = 1;
        end
    end
    
    if (boundary_choice == 1)
        % Top
        input_image_index_row = input_image_size(1);
        padded_matrix_index_row = offset;
        
        while (padded_matrix_index_row >= 1)                
            for loop2 = 1:input_image_size(2)
                padded_matrix(padded_matrix_index_row, loop2 + offset) = input_image(input_image_index_row, loop2);
            end
            
            padded_matrix_index_row = padded_matrix_index_row - 1;
            input_image_index_row = input_image_index_row - 1;
        end

        % Left
        input_image_index_col = input_image_size(2);
        padded_matrix_index_col = offset;
        
        while (padded_matrix_index_col >= 1)
            for loop2 = 1:input_image_size(1)
                padded_matrix(loop2 + offset, padded_matrix_index_col) = input_image(loop2, input_image_index_col);
            end
            
            padded_matrix_index_col = padded_matrix_index_col - 1;
            input_image_index_col = input_image_index_col - 1;
        end

        % Right
        input_image_index_col = 1;
        padded_matrix_index_col = padded_matrix_size(2) - offset + 1;
        
        while (padded_matrix_index_col <= padded_matrix_size(2))
            for loop2 = 1:input_image_size(1)
                padded_matrix(loop2 + offset, padded_matrix_index_col) = input_image(loop2, input_image_index_col);
            end
            
            padded_matrix_index_col = padded_matrix_index_col + 1;
            input_image_index_col = input_image_index_col + 1;
        end

        % Bottom
        input_image_index_row = 1;
        padded_matrix_index_row = padded_matrix_size(1) - offset + 1;
        
        while (padded_matrix_index_row <= padded_matrix_size(1))
            for loop2 = 1:input_image_size(2)
                padded_matrix(padded_matrix_index_row, loop2 + offset) = input_image(input_image_index_row, loop2);
            end
            
            padded_matrix_index_row = padded_matrix_index_row + 1;
            input_image_index_row = input_image_index_row + 1;
        end
    elseif (boundary_choice == 2)
        % Top
        for loop1 = 1:offset
            for loop2 = 1:input_image_size(2)
                padded_matrix(loop1, loop2 + offset) = input_image(1, loop2);
            end
        end

        % Left
        for loop1 = 1:offset
            for loop2 = 1:input_image_size(2)
                padded_matrix(loop2 + offset, loop1) = input_image(loop2, 1);
            end
        end

        % Right
        for loop1 = (padded_matrix_size(2)-(offset + 1)):padded_matrix_size(2)
            for loop2 = 1:input_image_size(1)
                padded_matrix(loop2 + offset, loop1) = input_image(loop2, input_image_size(2));
            end
        end

        % Bottom
        for loop1 = (padded_matrix_size(1)-(offset + 1)):padded_matrix_size(1)
            for loop2 = 1:input_image_size(2)
                padded_matrix(loop1, loop2 + offset) = input_image(input_image_size(1), loop2);
            end
        end
    elseif (boundary_choice == 3)
        % Top
        padded_matrix_index_row = offset;
        input_image_index_col = input_image_size(2);
        
        while (padded_matrix_index_row >= 1)
            padded_matrix_index_col = offset + 1;
            input_image_index_row = input_image_size(1);
            
            while (padded_matrix_index_col <= offset + input_image_size(2))
                padded_matrix(padded_matrix_index_row, padded_matrix_index_col) = input_image(input_image_index_row, input_image_index_col);
                padded_matrix_index_col = padded_matrix_index_col + 1;
                input_image_index_row = input_image_index_row - 1;
            end
            
            padded_matrix_index_row = padded_matrix_index_row - 1;
            input_image_index_col = input_image_index_col - 1;
        end

        % Left
        padded_matrix_index_col = offset;
        input_image_index_row = input_image_size(1);
                
        while (padded_matrix_index_col >= 1)
            padded_matrix_index_row = offset + 1;
            input_image_index_col = input_image_size(2);
            
            while (padded_matrix_index_row <= input_image_size(1) + offset)
                padded_matrix(padded_matrix_index_row, padded_matrix_index_col) = input_image(input_image_index_row, input_image_index_col);
                padded_matrix_index_row = padded_matrix_index_row + 1;
                input_image_index_col = input_image_index_col - 1;
            end
            
            padded_matrix_index_col = padded_matrix_index_col - 1;
            input_image_index_row = input_image_index_row - 1;
        end

        % Right
        padded_matrix_index_col = offset + input_image_size(2) + 1;
        input_image_index_row = 1;
                
        while (padded_matrix_index_col <= (input_image_size(2) + (kernel_size(1)-1)))
            padded_matrix_index_row = offset + 1;
            input_image_index_col = input_image_size(2);
            
            while (padded_matrix_index_row <= input_image_size(1) + offset)
                padded_matrix(padded_matrix_index_row, padded_matrix_index_col) = input_image(input_image_index_row, input_image_index_col);
                padded_matrix_index_row = padded_matrix_index_row + 1;
                input_image_index_col = input_image_index_col - 1;
            end
            
            padded_matrix_index_col = padded_matrix_index_col + 1;
            input_image_index_row = input_image_index_row + 1;
        end

        % Bottom
        padded_matrix_index_row = offset + input_image_size(1) + 1;
        input_image_index_col = input_image_size(2);
        
        while (padded_matrix_index_row <= padded_matrix_size(1))
            padded_matrix_index_col = offset + 1;
            input_image_index_row = input_image_size(1);
            
            while (padded_matrix_index_col <= offset + input_image_size(2))
                padded_matrix(padded_matrix_index_row, padded_matrix_index_col) = input_image(input_image_index_row, input_image_index_col);
                padded_matrix_index_col = padded_matrix_index_col + 1;
                input_image_index_row = input_image_index_row - 1;
            end
            
            padded_matrix_index_row = padded_matrix_index_row + 1;
            input_image_index_col = input_image_index_col - 1;
        end
    end
    
    % disp('image_filtering: Edge conditions complete!');
    if (mod(kernel_size(1),2) == 0)
        for i = startrow:(input_image_size(1))
            for j = startcol:(input_image_size(2))
                temp_matrix = padded_matrix(i:i+offset, j:j+offset) .* kernel_input;
                filtered_image(i-offset,j-offset) = mean(temp_matrix(:));
            end
        end
    else
        for i = startrow:(input_image_size(1) + offset)
            for j = startcol:(input_image_size(2) + offset)
                temp_matrix = padded_matrix(i-offset:i+offset,j-offset:j+offset) .* kernel_input;
                filtered_image(i-offset,j-offset) = mean(temp_matrix(:));
            end
        end
    end
    
    output_image = filtered_image;
    
    % disp('image_filtering: Filtering complete!');
    
    % figure;
    % imshow(filtered_image);
end