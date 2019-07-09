% make_gaussian_kernel.m
%
% Part Of: In-Class Exercise 3
%
% Created By: Matthew Lonis
% Created On: 5 February 2018
% Last Modified By: Matthew Lonis
% Last Modified On: 6 February 2018

function kernel = make_gaussian_kernel(size, sigma)
    % disp('Distributed Gaussian Kernel');
    % disp(' ');
    
    % My code
    [U,V] = meshgrid(linspace(-2, 2, size));
    kernel = exp((-1/(sigma^2))*(U.^2+V.^2));
    
    % Uncomment to graph kernel
    %
    % hs = surf(U, V, kernel);
    % hs.EdgeColor = 'none';
    
    % Ajinkya Chavan's recommended code
    %
    % [X,Y] = meshgrid(linspace(-2, 2, size));
    % G = exp(-(X.^2+Y.^2)/(2*sigma^2));
    % kernel = exp(G)/(2*pi*sigma*sigma);

    % Debug help to print our kernel contents
    %
    % disp(kernel);
end
