% this selects images from directories and runs the matlab calibration
% toolbox

% folder to matlab calibration toolbox
toolbox_folder = '/home/tabuhashim/Documents/MATLAB/resources/TOOLBOX_calib'; 

data_folder = cell(1, 4);
data_images = cell(1, 4);

% folders to image
data_folder{1}.folder = '/home/tabuhashim/Documents/MATLAB/koroibot/stereo/data/ikea/black/head_1';
data_folder{2}.folder = '/home/tabuhashim/Documents/MATLAB/koroibot/stereo/data/ikea/black/head_2';
data_folder{3}.folder = '/home/tabuhashim/Documents/MATLAB/koroibot/stereo/data/ikea/black/head_3';
data_folder{4}.folder = '/home/tabuhashim/Documents/MATLAB/koroibot/stereo/data/ikea/black/head_4';

% manual selection of left image name-numbers in each folder
data_images{1}.left = [88 494 510 555 1500 1522];
data_images{2}.left = [11 24 40 138 218 229 396 410 645 652 660 667 674 768 857];
data_images{3}.left = [59 64 68 246 258 327 423 438 681 685 690 695 698 780 787 794 865 874 881];
data_images{4}.left = [71 74 76 145 150 153 260 326];

% get the corresponding right images
% selection by synching with the left image timestamps
% for i = 1:nfolders; 
%     [~, ~, ~, ~, ~, ~, ~, imgl, imgr] = icub_load_data(data_folder{i}.folder);
%     id = data_images{i}.left + 1; % image name starts at 00000000.ppm
%     [A, i3] = min(abs(repmat(imgr.t,1,size(imgl.t,1)) - repmat(imgl.t',size(imgr.t,1),1)));
%     data_images{i}.right = i3(id) - 1; % image name starts at 00000000.ppm
% end

% manual selection of right images (they do not match the left images selected above.
data_images{1}.right = [90 465 500 525 1090 1480];
data_images{2}.right = [10 25 40 110 120 133 229 324 376 390 410 650 656 662 670 678 733 748 760 845 858 934 1036 1224];
data_images{3}.right = [59 68 139 149 247 325 421 431 439 682 687 693 778 785 873];
data_images{4}.right = [74 147 329 435 446];

% selection of image pairs using g-input

% total number of left images
nfolders = size(data_folder, 2);
nlimages = 0;
for i = 1:nfolders;
    nlimages = nlimages + size(data_images{i}.left, 2);
end

% get the images and rename them sequentially
prefix = 'img_'; k = 0;
cd(toolbox_folder);
% for i = 1:nfolders;
%     for j = 1:size(data_images{i}.left, 2);
%         k = k + 1;
%         I1 = imread( sprintf([data_folder{i}.folder,'/img/left/%08d.ppm'],data_images{i}.left(j)) );
%         imwrite( I1, sprintf([prefix,'%02d.ppm'],k) );
%     end
% end
for i = 1:nfolders;
    for j = 1:size(data_images{i}.right, 2);
        k = k + 1;
        I2 = imread( sprintf([data_folder{i}.folder,'/img/right/%08d.ppm'],data_images{i}.right(j)) );
        imwrite( I2, sprintf([prefix,'%02d.ppm'],k) );
    end
end

% run the calibration
if k>0; calib_gui; end
