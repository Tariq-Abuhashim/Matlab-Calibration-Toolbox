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
    
    % right_images = [111 140 181  221  317  462  752 ...
    %     956  1069 1284 1338 1444 1492 1584 1657 1748 ...
    %     1891 2130 2231 2272 2310 2495 2605 2637 2672 ...
    %     2722 2768 2915 3013 3063 3349 3554 3615 3707 3825];

    folder = '/home/tabuhashim/Documents/MATLAB/koroibot/stereo/data/blue/calib_22042015_1/img';
    save_dir = '/home/tabuhashim/Documents/MATLAB/koroibot/stereo/data/blue/combined_calib_22042015';
    right_images =  [151 186 329 398 489 614 782 871 1128 1212 1275 1316 ...
                    1344 1390 1458 1492 1562 1668 1715 1783 1904 1977 ...
                    2096 2212 2249 2318 2341 2435 2545 2586 2698 2737 2944];
    nright = length(right_images);
    for j = 1:nright;
        k = k + 1;
        I2 = imread( sprintf([folder,'/right_dist/%08d.ppm'],right_images(j)));
        imwrite( I2, sprintf([save_dir,'/right_dist',prefix,'%02d.ppm'],k) );
    end
    
    folder = '/home/tabuhashim/Documents/MATLAB/koroibot/stereo/data/blue/calib_22042015_2/img';
    save_dir = '/home/tabuhashim/Documents/MATLAB/koroibot/stereo/data/blue/combined_calib_22042015';
    right_images =  [71 98 164 275 330 431 667 735 856 890 934 1048 1087 ...
                    1263 1387 1531 1572 1643 1725]; % calib_22042015_2 - right_dist
    nright = length(right_images);
    for j = 1:nright;
        k = k + 1;
        I2 = imread( sprintf([folder,'/right_dist/%08d.ppm'],right_images(j)));
        imwrite( I2, sprintf([save_dir,'/right_dist',prefix,'%02d.ppm'],k) );
    end
    
end

%% run the calibration
if 1
    if k>0;
        cd(sprintf([save_dir,'/right_dist']));
        %calib_gui; % standard calibration toolbox
        calib; % abdallah kassir calibration toolbox
    end
end