he = imread('InClassExercise8_images/img1.jpg');

% lab_he = rgb2lab(he);
lab_he = im2double(he);

ab = lab_he(:,:,:);
nrows = size(ab,1);
ncols = size(ab,2);
nspace = size(ab,3);
ab = reshape(ab, [nrows*ncols, 3]);

nColors = 3;
% repeat the clustering 3 times to avoid local minima
[cluster_idx, cluster_center] = kmeans(ab,nColors,'distance','sqEuclidean', ...
                                      'Replicates',3);

pixel_labels = reshape(cluster_idx,nrows,ncols);
% figure;
% imshow(pixel_labels,[]), title('image labeled by cluster index');

segmented_images = cell(1,3);
rgb_label = repmat(pixel_labels,[1 1 3]);
color = lab_he;
for x = 1:nrows
    for y = 1:ncols
        group_num = pixel_labels(x, y);
        color(x, y, 1) = cluster_center(group_num, 1);
        color(x, y, 2) = cluster_center(group_num, 2);
        color(x, y, 3) = cluster_center(group_num, 3);
    end
end

figure;
imshow(color), title('color');
