k=0;
image_names=dir('stereo/*.ppm');
for i=1:size(image_names,1)
    im=imread(strcat('stereo/',image_names(i).name));
    left=im(1:480,1:640,:);
    right=im((1:480),(1:640) +640,:);
    k=k+1;
    imwrite(left,sprintf([save_folder,'/left/left','%03d.ppm'],k));
    imwrite(right,sprintf([save_folder,'/right/right','%03d.ppm'],k));
end