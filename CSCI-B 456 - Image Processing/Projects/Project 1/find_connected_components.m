function resulting_image = find_connected_components(input_matrix, connectivity)
    % local variables
    visited_indices = false(size(input_matrix)); % Used to tell if we've visited a location before
    [rows, cols] = size(input_matrix); % Used to get dimension of input_matrix
    current_group_ID = 1; % Track ID used for components
    
    % Loop through every row/column of the input_matrix
    for x = 1 : cols
        for y = 1 : rows
            if input_matrix(y,x) == 0
                visited_indices(y,x) = true; 
            elseif visited_indices(y,x)
                continue;
            else
                indices_considered_for_grouping = [y x]; % Cannot pre-allocate in depth-first-search

                while ~isempty(indices_considered_for_grouping)
                    loc = indices_considered_for_grouping(1,:);
                    indices_considered_for_grouping(1,:) = [];
                    
                    if visited_indices(loc(1),loc(2))
                        continue;
                    end

                    visited_indices(loc(1),loc(2)) = true; % Mark as visited
                    input_matrix(loc(1),loc(2)) = current_group_ID; % Overwrite with connect ID
                    
                    if connectivity == 8
                        [locs_y, locs_x] = meshgrid(loc(2)-1:loc(2)+1, loc(1)-1:loc(1)+1);
                        locs_y = locs_y(:);
                        locs_x = locs_x(:);
                    else
                        locs_y = [loc(2)-1; loc(2)+1; loc(2); loc(2)];
                        locs_x = [loc(1); loc(1); loc(1)-1; loc(1)+1];
                    end

                    out_of_bounds = locs_x < 1 | locs_x > rows | locs_y < 1 | locs_y > cols;

                    locs_y(out_of_bounds) = [];
                    locs_x(out_of_bounds) = [];

                    is_visited = visited_indices(sub2ind([rows cols], locs_x, locs_y));

                    locs_y(is_visited) = [];
                    locs_x(is_visited) = [];

                    is_1 = input_matrix(sub2ind([rows cols], locs_x, locs_y));
                    locs_y(~is_1) = [];
                    locs_x(~is_1) = [];

                    indices_considered_for_grouping = [indices_considered_for_grouping; [locs_x locs_y]];
                end

                current_group_ID = current_group_ID + 1;
            end
        end
    end
    
    fprintf([repmat('%d\t', 1, size(input_matrix, 2)) '\n'], input_matrix');
    
    if connectivity == 4
        figure('Name','find_connected_components: 4-connectivity','NumberTitle','off');
    elseif connectivity == 8
        figure('Name','find_connected_components: 8-connectivity','NumberTitle','off');
    end
    
    resulting_image = image(input_matrix);
    
end