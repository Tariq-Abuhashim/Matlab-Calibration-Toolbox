% This file:
% 1- Extracts the image data and sync it all to the left images
% 2- Converts the images from ppm to png

folder = '/home/tabuhashim/Documents/MATLAB/koroibot/stereo/data/ikea/black/head_1';
addpath('/home/tabuhashim/Documents/MATLAB/koroibot/stereo/code/matlab/common');
addpath('/home/tabuhashim/Documents/MATLAB/koroibot/stereo/code/matlab/icub');
%opt.FOLDER=folder;
%opt.IMAGE_BASE='*.ppm';
%opt.freq=30;
%opt.STEPS=3;
%opt.FIRST_IMAGE= 840;
[cam_left, cam_right, eyes, neck, waist, folder] = set_images(folder);

% delete old and create new image directories
left_ppm = folder{1};
right_ppm = folder{2};
left_png = strcat(opt.FOLDER,'/img/left_png/');
right_png = strcat(opt.FOLDER,'/img/right_png/');
if isdir(left_png); 
    rmdir(left_png);
    rmdir(right_png);
end
mkdir(left_png);
mkdir(right_png);

% convert images
for i = 1:size(cam_left.image, 2)
    im = imread([left_ppm,cam_left.image{i}]);
    imwrite(im,[left_png,cam_left.image{i}(1:end-4),'.png'],'png');
    im = imread([right_ppm,cam_right.image{i}]);
    imwrite(im,[right_png,cam_right.image{i}(1:end-4),'.png'],'png');
end