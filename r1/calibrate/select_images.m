reply = input('Do you want to select calibration images? Y/N [N]:','s');
if strcmp(reply, 'Y')||strcmp(reply, 'y');
    prefix = '/img_';
    names = dir(strcat(images_folder,'/*.ppm'));
    k = 0; % first image number to rename - 1
    for i = 1:size(names, 1)
        img = imread(strcat(images_folder,'/',names(i).name));
        imshow(img); drawnow;
        reply = input('Do you want to use the image? Y/N [N]:','s');
        if isempty(reply)
            reply = 'N';
        end
        if strcmp(reply, 'Y')||strcmp(reply, 'y');
            k = k + 1;
            imwrite(img,sprintf([save_folder,'/stereo/',prefix,'%03d.ppm'],k));
            fprintf('Image %d written to folder\n', k);
        end
    end
else
    fprintf('Skipping image selection and moving to folder for calibration\n');
end