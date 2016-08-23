% The file icub_calibrate.m calibrates the cameras from images in multiple folders by intering the
% id numbers of images used without copying them first.
% This file, however, performs the calibration on a set of copies images in two separate folders of
% left and right cameras and using Abdallah Kaser automatic calibration toolbox.
% the file test.m, in the most recent version that prompts the user to loop through the images then
% type y or n to images to be copied for calibration. The files doesn't run the calibration though.

close all; clear; clc;

% this folder
addpath('/home/tabuhashim/Documents/data/r1/calibrate');

% where is the calibration toolbox ?
%addpath('/home/tabuhashim/Documents/data/r1/calibrate/TOOLBOX_calib'); %traditional implementation
addpath('/home/tabuhashim/Documents/data/r1/calibrate/RADOCCToolbox'); %Abdallah Kaser
addpath('/home/tabuhashim/Documents/data/r1/calibrate/RADOCCToolbox/CornerFinder'); %Abdallah Kaser

% where are the images? where to save the results?
images_folder = '/home/tabuhashim/Documents/data/r1/R1_calib_20160819'; 
save_folder = strcat(images_folder,'/results/run_1'); mkdir(save_folder);

% select chess-board images to be used (Unfortunately, you have to manually go through the
% images)
cd(save_folder);mkdir('stereo');
select_images;

% split the stereo image into left and right
cd(save_folder);mkdir('left');mkdir('right');
plit_and_rename;

% left calibration
cd(strcat(save_folder,'/left'));
%calib; % abdallah kassir calibration toolbox
data_calib; % loads the images
click_calib; % extracts corners
go_calib_optim; % performs calibration
saving_calib; % saves the calibration
movefile('Calib_Results.mat','../Calib_Results_left.mat');

% right calibration
cd(strcat(save_folder,'/right'));
%calib; % abdallah kassir calibration toolbox
data_calib; % loads the images
click_calib; % extracts corners
go_calib_optim; % performs calibration
saving_calib; % saves the calibration
movefile('Calib_Results.mat','../Calib_Results_right.mat');

% stereo calibration
cd(save_folder);
%stereo_gui;
load_stereo_calib_files; % reads Calib_Results_left.mat and Calib_Results_right.mat
calib_stereo;