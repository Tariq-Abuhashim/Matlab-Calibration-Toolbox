% This code can be used to test the icub logged data

data_dir = '/home/tabuhashim/Documents/MATLAB/koroibot/stereo/data/ikea/ikea_head_3';
addpath('/home/tabuhashim/Documents/MATLAB/koroibot/stereo/code/matlab/common');
set_folders;
    
% STEP 1 : plot all data
% ----------------------
% get icub data
[imu, hd, lh, rh, la, ra, tor, imgl, imgr] = icub_load_data(data_dir);
icub_plot_data (imu, hd, lh, rh, la, ra, tor, imgl, imgr);

% STEP 2 : process time stamps
% ----------------------
% images used
image_id = 1:length(imgl.t); % all images
% sync time stamps with the left images
[eyes, neck, waist, cam_left, cam_right] = sync_images_with_encoders(imgl, imgr, hd, tor, image_id);
figure;
plot([eyes; neck]'*180/pi, 'linewidth', 2); grid on;
legend('tilt', 'pan', 'vergence', 'head roll', 'head pitch', 'head yaw');
xlabel('images'); ylabel('angles in degrees');
figure;
plot(waist'*180/pi, 'linewidth', 2); grid on;
legend('waist roll', 'waist pitch', 'waist yaw');
xlabel('images'); ylabel('angles in degrees');
figure;
plot(imgl.t); hold on; plot(imgr.t,'r');
figure;
plot(diff(imgl.t)); hold on; plot(diff(imgr.t),'r');

% STEP 3 : check features extraction and matching
% ----------------------

% STEP 4 : check pairwise geometry
% ----------------------

% STEP 5 : check dense matching
% ----------------------