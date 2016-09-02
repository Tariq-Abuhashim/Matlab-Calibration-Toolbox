% The file icub_calibrate.m calibrates the cameras from images in multiple folders by intering the
% id numbers of images used without copying them first.
% This file, however, performs the calibration on a set of copies images in two separate folders of
% left and right cameras and using Abdallah Kaser automatic calibration toolbox.
% the file test.m, in the most recent version that prompts the user to loop through the images then
% type y or n to images to be copied for calibration. The files doesn't run the calibration though.

close all; clear; clc;

% this folder
addpath('/home/tabuhashim/Documents/data/icub/calibrate');

% where is the calibration toolbox ?
%addpath('/home/tabuhashim/Documents/MATLAB/resources/TOOLBOX_calib'); %traditional implementation
addpath('/home/tabuhashim/Documents/data/icub/calibrate/RADOCCToolbox'); %Abdallah Kaser
addpath('/home/tabuhashim/Documents/data/icub/calibrate/RADOCCToolbox/CornerFinder'); %Abdallah Kaser

% LEFT
% (images were taken from different runs, and put in folder "used", hence all images have been
% used and no need for numbering. If numbering is needed, use the same script used from the right
% images bellow
images_folder='/home/tabuhashim/Documents/data/icub/WalkingDatasets_2/Calib_left/images/left';
save_folder=strcat(images_folder,'/results/run_1'); mkdir(save_folder);
% select chess-board images to be used (Unfortunately, you have to manually go through the
% images)
cd(save_folder);
select_images;
% Run the calibration
cd(save_folder);
%calib_gui; % standard calibration toolbox
%calib; % abdallah kassir calibration toolbox
data_calib; % loads the images
click_calib; % extracts corners
go_calib_optim; % performs calibration
saving_calib; % saves the calibration
%analyse_error; % error analysis
%show_calib_results;

% RIGHT
% (images were taken from different runs, and put in folder "used", hence all images have been
% used and no need for numbering. If numbering is needed, use the same script used from the right
% images bellow
images_folder='/home/tabuhashim/Documents/data/icub/WalkingDatasets_2/Calib_left/images/right';
save_folder=strcat(images_folder,'/results/run_1'); mkdir(save_folder);
% select chess-board images to be used (Unfortunately, you have to manually go through the
% images)
cd(save_folder);
select_images;
% Run the calibration
cd(save_folder);
%calib_gui; % standard calibration toolbox
%calib; % abdallah kassir calibration toolbox
data_calib; % loads the images
click_calib; % extracts corners
go_calib_optim; % performs calibration
saving_calib; % saves the calibration
%analyse_error; % error analysis
%show_calib_results;