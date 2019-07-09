function find_show_distance(input_matrix, location_1, location_2, distance_measure)
    x = location_1(1);
    y = location_1(2);
    s = location_2(1);
    t = location_2(2);
    
    if distance_measure == 0
        distance = sqrt((x - s)^2 + (y - t)^2);
    elseif distance_measure == 2
        distance = abs(x - s) + abs(y - t);
    else
        distance = max(abs(x - s), abs(y - t));
    end
    
    text_distance = ['Distance = ' num2str(distance, '%0.2f')];
    %position = [round(abs(x - s) / 2, 0) round(abs(y - t) / 2, 0)];
    %box_color = 'white';
    
    if distance_measure == 0
        figure('Name','find_show_distance: Euclidean Distance','NumberTitle','off');
    elseif distance_measure == 1
        figure('Name','find_show_distance: Manhattan Distance','NumberTitle','off');
    elseif distance_measure == 2
        figure('Name','find_show_distance: Chessboard Distance','NumberTitle','off');
    end
    
    %RGB = insertText(input_matrix, position, text_distance, 'FontSize', 50, 'BoxColor', box_color, 'BoxOpacity', 1, 'TextColor', 'black');
    image(input_matrix);
    %image(RGB);
    
    hold on;
    
    text(round(abs(x - s) / 2, 0), round(abs(x - s) / 2, 0), text_distance,'Rotation',0,'FontSize',12);
    
    line([x, s], [y, t]);
    hold off;
    
end