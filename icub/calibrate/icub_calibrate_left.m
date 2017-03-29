function icub_calibrate_left(run_id)
% The file 
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
% Genova, Italy, 2017

%data_path = '/media/tariq/SEAGATE/Data/icub/WalkingDatasets_2' ;
% where is the calibration toolbox ?
%addpath('/home/tabuhashim/Documents/MATLAB/resources/TOOLBOX_calib'); %traditional implementation
addpath( './RADOCCToolbox' ) ; %Abdallah Kaser
addpath( './RADOCCToolbox/CornerFinder' ) ; %Abdallah Kaser

disp( 'Calibrating left images');

left_image_path = './data/Calib_left/images/left' ;
disp( ['left_image_path : ', left_image_path] );

calib_path = strcat( left_image_path, '/results/run_', num2str(run_id) ) ; mkdir( calib_path ) ;
disp( ['calib_path : ', calib_path] );

disp( 'Reading from image_path and then copying calibration images to copy_path ...' ) ;
copy_calib_images( left_image_path, calib_path ) ;
	
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
