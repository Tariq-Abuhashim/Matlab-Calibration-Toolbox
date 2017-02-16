
% LEFT
close all; clear; clc;
left_folder='/home/tabuhashim/Documents/data/WalkingDatasets/data_calibration/img/left'; 
names = dir(strcat(left_folder,'/*.ppm'));
for i = 1:2:size(names, 1)
    delete(strcat(left_folder,'/',names(i).name));
end


% RIGHT
close all; clear; clc;
right_folder='/home/tabuhashim/Documents/data/WalkingDatasets/data_calibration/img/right';
names = dir(strcat(right_folder,'/*.ppm'));
for i = 1:2:size(names, 1)
    delete(strcat(right_folder,'/',names(i).name));
end