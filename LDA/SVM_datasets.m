
function [Train_Set,Test_Set,train_label] = SVM_datasets(TrainingSet_location, No_Trainset, No_Testset,width, height)
% This function will generate the Training set, random Test set, and
% training class for multiSVM 
% Please use the output of my DirRead function as a input 
% http://www.mathworks.com/matlabcentral/fileexchange/40020-dir-read/content/DirRead.m

% Inputs                : TraininSet_location, No_Testset,width,height
% TraininSet_location   : Only o/p of function DirRead is accepted or an
% array of locations
% No_Testset            : No of test set needed per class for svm train
% No_Trainset            : No of test set needed per class for svm train
% width, height         : Resize parameters
%             %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Outputs               : Train_set, Test_set, train_label
% Train_set             : Training set ready for svm training
% Test_set              : Test set ready for svm classify
% train_label           : Training set class label
% ----------------------------------------------------------
% 
% ----------------------------------------------------------
% This function is written by Om choudhary and this is free to use.
% Email: choudharyom@hotmail.com

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
end

