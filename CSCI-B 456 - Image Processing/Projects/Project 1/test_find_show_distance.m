input_matrix = randi([0,1], 1080, 1920);
location_1 = [1, 1];
location_2 = [1920, 1080];

find_show_distance(input_matrix, location_1, location_2, 0);
find_show_distance(input_matrix, location_1, location_2, 1);
find_show_distance(input_matrix, location_1, location_2, 2);