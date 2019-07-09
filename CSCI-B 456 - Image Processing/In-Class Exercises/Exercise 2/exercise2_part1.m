img = imread('l_t.jpg');
img_ref = imref2d(size(img));

figure('Name','Original Image','NumberTitle','off');
imshow(img);

% Affine Transformation - Translation

T = [1 0 0; 0 1 0; 100 100 1]; % Translation Matrix
disp(T);
tform = affine2d(T);
img_translated_ref = img_ref;
img_translated_ref.XWorldLimits(2) = img_translated_ref.XWorldLimits(2)+100;
img_translated_ref.YWorldLimits(2) = img_translated_ref.YWorldLimits(2)+100;
[img_translated, img_translated_ref] = imwarp(img, tform, 'OutputView', img_translated_ref);

figure('Name','Translated Image','NumberTitle','off');
imshow(img_translated, img_translated_ref);
imwrite(img_translated, 'l_t_translated.jpg', 'jpg');

% Affine Transformation - Scale

T = [2 0 0; 0 2 0; 0 0 1]; % Scale Matrix
disp(T);
tform = affine2d(T);
img_scale_ref = img_ref;
img_scale_ref.XWorldLimits(2) = img_scale_ref.XWorldLimits(2)*2;
img_scale_ref.YWorldLimits(2) = img_scale_ref.YWorldLimits(2)*2;
[img_scale, img_scale_ref] = imwarp(img, tform, 'OutputView', img_scale_ref);

figure('Name','Scaled Image','NumberTitle','off');
imshow(img_scale, img_scale_ref);
imwrite(img_scale, 'l_t_scaled.jpg', 'jpg');

% Affine Transformation - Shear (vertical)

T = [1 1 0; 0 1 0; 0 0 1]; % Shear Matrix
disp(T);
tform = affine2d(T);
img_shear_ref = img_ref;
img_shear_ref.XWorldLimits(2) = img_shear_ref.XWorldLimits(2)+400;
img_shear_ref.YWorldLimits(2) = img_shear_ref.YWorldLimits(2)+400;
[img_shear, img_shear_ref] = imwarp(img, tform, 'OutputView', img_shear_ref);

figure('Name','Sheared (vertical) Image','NumberTitle','off');
imshow(img_shear, img_shear_ref);
imwrite(img_shear, 'l_t_sheared.jpg', 'jpg');

% Affine Transformation - Rotation

% T = rotx(30); Rotation Matrix around x-axis by 30 degrees using phased
% array system toolbox
T = [0.866 0.5 0; -0.5 0.866 0; 0 0 1];
disp(T);
tform = affine2d(T);
img_rotation_ref = img_ref;
img_rotation_ref.XWorldLimits(2) = img_rotation_ref.XWorldLimits(2);
img_rotation_ref.YWorldLimits(2) = img_rotation_ref.YWorldLimits(2);
[img_rotation, img_rotation_ref] = imwarp(img, tform, 'OutputView', img_rotation_ref);

figure('Name','Rotated Image','NumberTitle','off');
imshow(img_rotation, img_rotation_ref);
imwrite(img_rotation, 'l_t_rotated.jpg', 'jpg');