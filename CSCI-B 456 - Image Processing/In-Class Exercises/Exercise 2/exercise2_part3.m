kernel = randi([-2, 2], 5, 5);

disp('Original kernel');
disp(' ');
disp(kernel);
disp(' ');
disp('Distributed Gaussian Kernel');
disp(' ');

size=5;
sigma=1.76; %standard deviation

%gaussian filter
for i = -(size-1)/2:(size-1)/2
    for j = -(size-1)/2:(size-1)/2
        x0 = (size+1)/2; %center
        y0 = (size+1)/2; %center
        x = i+x0; %row
        y = j+y0; %col
        kernel(y,x) = exp(-((x-x0)^2+(y-y0)^2)/2/sigma/sigma);
    end
end

disp(kernel);
figure;
plot(kernel);
title('Kernel Distribution');
xlabel('Matrix Column');
ylabel('Value');
legend('Matrix Row 1','Matrix Row 2','Matrix Row 3','Matrix Row 4','Matrix Row 5');