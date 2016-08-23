% The file icub_calibrate.m calibrates the cameras from images in multiple folders by intering the
% id numbers of images used without copying them first.
% This file, however, performs the calibration on a set of copies images in two separate folders of
% left and right cameras and using Abdallah Kaser automatic calibration toolbox.
% the file test.m, in the most recent version that prompts the user to loop through the images then
% type y or n to images to be copied for calibration. The files doesn't run the calibration though.

% where is the calibration toolbox ?
%addpath('/home/tabuhashim/Documents/MATLAB/resources/TOOLBOX_calib'); %traditional implementation
addpath('/home/tabuhashim/Documents/data/RADOCCToolbox'); %Abdallah Kaser
addpath('/home/tabuhashim/Documents/data/RADOCCToolbox/CornerFinder'); %Abdallah Kaser
%
%

% LEFT
% (images were taken from different runs, and put in folder "used", hence all images have been
% used and no need for numbering. If numbering is needed, use the same script used from the right
% images bellow
close all; clear; clc;
left_folder='/home/tabuhashim/Documents/data/WalkingDatasets/data_calibration/img/left';
save_left = strcat(left_folder,'/results/run_1');mkdir(save_left);
reply = input('Do you want to select left images? Y/N [N]:','s');
if strcmp(reply, 'Y')||strcmp(reply, 'y');
    prefix = '/img_';
    names = dir(strcat(left_folder,'/*.ppm'));
    k = 0; % first image number to rename - 1
    for i = 1:size(names, 1)
        img = imread(strcat(left_folder,'/',names(i).name));
        img = img(5:end-4,5:end-4,:);
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
end
% Run the calibration
cd(save_left);
%calib_gui; % standard calibration toolbox
calib; % abdallah kassir calibration toolbox
data_calib; % loads the images
click_calib; % extracts corners
go_calib_optim; % performs calibration
saving_calib; % saves the calibration
%analyse_error; % error analysis
%show_calib_results;

% RIGHT
close all; clear; clc;
right_folder='/home/tabuhashim/Documents/data/WalkingDatasets/data_calibration/img/right';
save_right = strcat(right_folder,'/results/run_1');mkdir(save_right);
reply = input('Do you want to select right images? Y/N [N]:','s');
if strcmp(reply, 'Y')||strcmp(reply, 'y');
    prefix = '/img_';
    names = dir(strcat(right_folder,'/*.ppm'));
    k = 0; % first image number to rename - 1
    for i = 1:size(names, 1)
        img = imread(strcat(right_folder,'/',names(i).name));
        %img = img(5:end-4,5:end-4,:);
        imshow(img); drawnow;
        reply = input('Do you want to use the image? Y/N [N]:','s');
        if isempty(reply)
            reply = 'N';
        end
        if strcmp(reply, 'Y')||strcmp(reply, 'y');
            k = k + 1;
            imwrite(img,sprintf([save_right,'/',prefix,'%03d.ppm'],k));
        end
    end
end
% Run the calibration
cd(save_right);
%calib_gui; % standard calibration toolbox
calib; % abdallah kassir calibration toolbox
data_calib; % loads the images
click_calib; % extracts corners
go_calib_optim; % performs calibration
saving_calib; % saves the calibration
%analyse_error; % error analysis
%show_calib_results;