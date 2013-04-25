clc 
clear all

width =140;height=140;

% Training set location & no of test image to use per class
TrainingSet_add = 'F:\101_ObjectCategories';
No_Testset      = 50;
No_Trainset     = 15;

% Process the Training set location
 TrainingSet_location = DirRead(TrainingSet_add,'*.jpg');
 

 Train_Set      = [];
 Train_Set_tmp  = [];
 Test_Set       = []; 
 imageArray     = cell(No_Testset, 1);
 train_label    = [];
     for i=1:length(TrainingSet_location)

         % Training set process
         No_of_Files=length(dir(fullfile(TrainingSet_location{i},'*.jpg')));
         k = dir(fullfile(TrainingSet_location{i},'*.jpg'));
         k = {k(~[k.isdir]).name}; 
         No = No_Trainset+No_Testset;
         if (No > No_of_Files)
             No = No_of_Files;
         end
         for j=1:No
            tempImage       = imread(horzcat(TrainingSet_location{i},filesep,k{j}));
            imgInfo         = imfinfo(horzcat(TrainingSet_location{i},filesep,k{j}));

             % Image transformation
             if strcmp(imgInfo.ColorType,'grayscale')
                imageArray{j}   = double(imresize(tempImage,[width height])); % array of images
             else
                imageArray{j}   = double(imresize(rgb2gray(tempImage),[width height])); % array of images
             end
         end
         Train_Set_tmp       = imageArray;
         imageArray          = cell(No_Trainset, 1);
         
         % Training set
         for k=1:No_Trainset
             Train_Set = [Train_Set; Train_Set_tmp(k) ];
             Train_Set_tmp{k} =  {};
             
             % Training set label
             train_label   = [train_label; i ];
         end
         Train_Set_tmp = Train_Set_tmp(~cellfun(@isempty, Train_Set_tmp));
         
         % Test set
         for l=1:length(Train_Set_tmp)
             Test_Set = [Test_Set; Train_Set_tmp(l) ];
         end
     end



















