input_matrix = randi([0,1], 128, 128);
con4 = 4;
con8 = 8;

disp('Input Matrix');
disp(' ');
fprintf([repmat('%d\t', 1, size(input_matrix, 2)) '\n'], input_matrix')

disp(' ');
disp('Resulting Matrix - 4 Connectivity');
disp(' ');

find_connected_components(input_matrix, con4);

test4bwlabel = bwlabel(input_matrix, 4);

disp(' ');
disp('Bwlabel Matrix - 4 Connectivity');
disp(' ');

fprintf([repmat('%d\t', 1, size(test4bwlabel, 2)) '\n'], test4bwlabel');

disp(' ');
disp('As you can see, the output is the same');
disp(' ');

disp(' ');
disp('Resulting Matrix - 8 Connectivity');
disp(' ');

find_connected_components(input_matrix, con8);

test8bwlabel = bwlabel(input_matrix, 8);

disp(' ');
disp('Bwlabel Matrix - 8 Connectivity');
disp(' ');

fprintf([repmat('%d\t', 1, size(test8bwlabel, 2)) '\n'], test8bwlabel');

disp(' ');
disp('As you can see, the output is the same');
disp(' ');