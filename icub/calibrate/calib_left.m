clc; clear all; close all;

% notice that, there are two parts in this script:
% Part 1 : is concerned with renaming the images and saving them into a
% specified save directory
% Part 2 : runs the calibration given the save directory
% Each part can be run separatly or they can run together (combined
% calibration of two separate image sources, for example. One image is
% close to the camera and other images are far from the camera.

% where is the calibration toolbox ?
%addpath('/home/tabuhashim/Documents/MATLAB/resources/TOOLBOX_calib');
addpath('/home/tabuhashim/Documents/MATLAB/resources/RADOCCToolbox');
addpath('/home/tabuhashim/Documents/MATLAB/resources/RADOCCToolbox/CornerFinder');

%% read images and save with new id
if 1
    
    % list of calibration images
    prefix = '/img_';
    k = 0;
    
    % left_images =  [960 980 1113 1245 1334 1381 1420 ...
    %     1459 1509 1581 1645 1681 1848 1927 2041 2104 ...
    %     2330 2495 2574 2786 2972 3124 3189 3344 3470 ...
    %     3734 3941 4046 4119 4420];
    
    % left_images =  [258 349 418 581 614 764 950 1003 1118 1142 1165 1195 ...
    %     1227 1309 1488 1527 1576 1856 1923 1966 2164 2335 2357 2379 2464 ...
    %     2683 2750 2823 2885 3076 3096 3115 3295 3580 3786]; %calib_22042015 - left
    
    folder = '/home/tabuhashim/Documents/MATLAB/koroibot/stereo/data/blue/calib_22042015_1/img';
    save_dir = '/home/tabuhashim/Documents/MATLAB/koroibot/stereo/data/blue/combined_calib_22042015';
    left_images =  [170 509 528 577 600 775 803 888 911 ...
        929 974 1190 1233 1482 1517 1568 1608 1725 1910 2100 2227 2253 ...
        2378 2400 2440 2504 2671 2738 2765 2829 2916]; %calib_22042015_1 - left_dist
    nleft = length(left_images);
    for j = 1:nleft;
        k = k + 1;
        I2 = imread( sprintf([folder,'/left_dist/%08d.ppm'],left_images(j)));
        imwrite( I2, sprintf([save_dir,'/left_dist',prefix,'%02d.ppm'],k) );
    end

    folder = '/home/tabuhashim/Documents/MATLAB/koroibot/stereo/data/blue/calib_22042015_2/img';
    save_dir = '/home/tabuhashim/Documents/MATLAB/koroibot/stereo/data/blue/combined_calib_22042015';
    left_images =  [85 100 681 1780 1821 1851 1914 1995 2019 2051 2148 2219 ...
        2296 2376 2449 2482 2526 2565 2623 2732 2792 2826 2865 2887 2921]; %calib_22042015_2 - left_dist
    nleft = length(left_images);
    for j = 1:nleft;
        k = k + 1;
        I2 = imread( sprintf([folder,'/left_dist/%08d.ppm'],left_images(j)));
        imwrite( I2, sprintf([save_dir,'/left_dist',prefix,'%02d.ppm'],k) );
    end
end

%% run the calibration
if 1
    if k>0;
        cd(sprintf([save_dir,'/left_dist']));
        %calib_gui; % standard calibration toolbox
        calib; % abdallah kassir calibration toolbox
    end
end