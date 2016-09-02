reply = input('Do you want to select images? Y/N [Y]:','s');
if strcmp(reply, 'Y')||strcmp(reply, 'y')||isempty(reply);
    prefix = '/img_';
    names = dir(strcat(images_folder,'/*.ppm'));
    k = 0; % first image number to rename - 1
    for i = 1:size(names, 1)
        img = imread(strcat(images_folder,'/',names(i).name));
        %img = img(5:end-4,5:end-4,:);
        imshow(img); drawnow;
        reply = input('Do you want to use the image? Y/N [N]:','s');
        if isempty(reply)
            reply = 'N';
        end
        if strcmp(reply, 'Y')||strcmp(reply, 'y');
            k = k + 1;
            imwrite(img,sprintf([save_left,postfix,'/','%03d.ppm'],k));
            fprintf('Image %d written to folder\n', k);
        end
    end
else
    fprintf('Skipping image selection and moving to folder for calibration\n');
end