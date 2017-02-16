function calibrate_v2(data_path, run_id)
% The file icub_calibrate.m calibrates the cameras from images in multiple folders by intering the
% id numbers of images used without copying them first.
% This file, however, performs the calibration on a set of copied images in two separate folders of
% left and right cameras and using Abdallah Kaser automatic calibration toolbox.
% the file test.m, is the most recent version that prompts the user to loop through the images then
% type y or n to images to be copied for calibration. The files doesn't run the calibration though.
%
% Inputs: 
%		data_path :  path to dataset main folder which contains the folder "images".
%       run_id    :  trial or run identification number.
% Images are expected to be located at "image_path", where:
% 		for left images : image_path = /data_path/Calib_left/images/left
% 		for right ight images : image_path = /data_path/Calib_right/images/right
% Images to be used for calibration are first copied from "image_path" to "copy_path", where:
%		copy_path = /image_path/results
% Calibration results from different calibration runs are save to a "calib_path", where:
%		calib_path = copy_path/run_(run_id)
%		where id is the identification number of the current calibration trial or run.
%
% For better results, perform two separate datadumper instances for each camera. Rename the data for
%		calibrating the left camera as "Calib_left", and the data for calibrating the right camera as
%       		"Calib_right". 
%		Where, both "Calib_left" and "Calib_right" contains the same directory structure:
%						/images/left 		and 	 	/images/right
%		While, "Calib_left" contains left images with full visibility of the calibration pattern, and
%			   "Calib_right" contains right images with full visibility of the calibration pattern.
%
% Make sure that the calibration pattern is covering as much as possible of the view (focus of corners).
%		This is where the distortion is the largest.
%
% Outputs will be saved in at "calib_path" using standards from Jean-Yves Bouguet's calibration toolbox
%
%	For iCub@iit and iCub@heidelberg.
%
% Tariq Abuhashim
% t.abuhashim@gmail.com
%
% Koroibot, iCub Facility, Istituto Italiano di Tecnologia
% Genova, Italy, 2015

%data_path = '/media/tariq/SEAGATE/Data/icub/WalkingDatasets_2' ;
% where is the calibration toolbox ?
%addpath('/home/tabuhashim/Documents/MATLAB/resources/TOOLBOX_calib'); %traditional implementation
addpath( './RADOCCToolbox' ) ; %Abdallah Kaser
addpath( './RADOCCToolbox/CornerFinder' ) ; %Abdallah Kaser

this_path = pwd;

try

	% LEFT
	disp( 'Select chess-board images to be used (Unfortunately, you have to manually go through the images).');
	image_path = strcat( data_path, '/Calib_left/images/left' ) ;
	disp( ['image_path : ', image_path] );
	calib_path = strcat( image_path, '/results/run_', num2str(run_id) ) ; mkdir( calib_path ) ;
	disp( ['calib_path : ', calib_path] );
	disp( 'Reading from image_path and then copying calibration images to copy_path ...' ) ;
	copy_calib_images( image_path, calib_path ) ;
	% Run the calibration
	%calib_gui ; % standard calibration toolbox
	%calib ; % abdallah kassir calibration toolbox
	disp( 'Prepairing calibration data ...' ) ;
	cd( calib_path ) ;
	data_calib ; % loads the images
	disp( 'Extracting grid corners ...' ) ;
	click_calib ; % extracts corners
	disp( 'Performing calibration ...' ) ;
	go_calib_optim ; % performs calibration
	disp( 'Saving calibration data to calib_path ...' ) ;
	saving_calib ; % saves the calibration
	%analyse_error ; % error analysis
	%show_calib_results ;

	% RIGHT
	disp( 'Select chess-board images to be used (Unfortunately, you have to manually go through the images).');
	image_path = strcat( data_path, '/Calib_right/images/right' ) ;
	disp( ['image_path : ', image_path] );
	calib_path = strcat( image_path, '/results/run_', num2str(run_id) ) ; mkdir( calib_path ) ;
	disp( ['calib_path : ', calib_path] );
	disp( 'Reading from image_path and then copying calibration images to copy_path ...' ) ;
	copy_calib_images( image_path, calib_path ) ;
	% Run the calibration
	%calib_gui ; % standard calibration toolbox
	%calib ; % abdallah kassir calibration toolbox
	disp( 'Prepairing calibration data ...' ) ;
	cd( calib_path ) ;
	data_calib ; % loads the images
	disp( 'Extracting grid corners ...' ) ;
	click_calib ; % extracts corners
	disp( 'Performing calibration ...' ) ;
	go_calib_optim ; % performs calibration
	disp( 'Saving calibration data to calib_path ...' ) ;
	saving_calib ; % saves the calibration
	%analyse_error ; % error analysis
	%show_calib_results ;

catch

	disp('FAILED ...');
	cd( this_path );

end
end

% the file test.m, in the most recent version that prompts the user to loop through the images then
% type y or n to images to be copied for calibration. The files doesn't run the calibration though.
function copy_calib_images(image_path, calib_path)
	names = dir( strcat(image_path,'/*.ppm') ) ;
	prefix = '/img_' ; 
	k = 0; % first image number to rename - 1
	for i = 1:size(names, 1)
    	img = imread( strcat(image_path,'/',names(i).name) ) ;
    	%img = img( 5:end-4,5:end-4,: ) ;
    	imshow( img ) ; drawnow ;
    	reply = input(['Use image ',names(i).name,' ? Y/N [N]:'],'s');
    	if isempty( reply )
        	reply = 'N';
    	end
    	if strcmp( reply, 'Y' ) || strcmp( reply, 'y' );
        	k = k + 1;
        	imwrite( img,sprintf([calib_path,'/',prefix,'%03d.ppm'],k) ) ;
    	end
	end
end
