% the file test.m, in the most recent version that prompts the user to loop through the images then
% type y or n to images to be copied for calibration. The files doesn't run the calibration though.

close all; clear all; clc;
folder='/home/tabuhashim/Documents/MATLAB/koroibot/stereo/data/blue/calib_20151207/right';
names = dir(strcat(folder,'/*.ppm'));
save_left = strcat(folder,'/results'); mkdir(save_left);
prefix = '/img_'; 
k = 0; % first image number to rename - 1
for i = 1:size(names, 1)
    img = imread(strcat(folder,'/',names(i).name));
    %img = img(5:end-4,5:end-4,:);
    imshow(img); drawnow;
    reply = input('Do you want to use the image? Y/N [N]:','s');
    if isempty(reply)
        reply = 'N';
    end
    if strcmp(reply, 'Y')||strcmp(reply, 'y');
        k = k + 1;
        imwrite(img,sprintf([save_left,'/',prefix,'%03d.ppm'],k));
    end
end