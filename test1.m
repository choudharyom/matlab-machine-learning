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
 Test_Set       = []; 
 imageArray     = cell(No_Testset, 1);
 From           = 1;
 upto           = 0;
     for i=1:length(TrainingSet_location)

         % Training set process
         x=i
         No_of_Files=length(dir(fullfile(TrainingSet_location{i},'*.jpg')))
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
         Train_Set       = [Train_Set; imageArray];
         length(Train_Set);
         imageArray      = cell(No_Trainset, 1);
         
         % SVM Train class Label
         upto = upto+j-No_Testset;
         train_label(From:upto,1)  = i;
         From = upto+1;

         % Test set process
         Test_Set_temp          = {};
         %No_of_Files=length(dir(fullfile(TrainingSet_location{i},'*.jpg')));
         
         if (No_Testset < No_of_Files)
             p=randperm(length(Train_Set),No_Testset);
         else
             p=randperm(No_of_Files-No_Trainset)
         end
            for k=1:length(p)
                 z=p(k);
                 Test_Set_temp{z}   =  Train_Set{z};
                 Train_Set{z}       =  {};
            end
             Train_Set = Train_Set(~cellfun(@isempty, Train_Set));
             Test_Set_temp = Test_Set_temp(~cellfun(@isempty, Test_Set_temp));
             Test_Set = [Test_Set, Test_Set_temp];
             length(Test_Set);
             T(i)=length(Train_Set)
     end
     
     
     
     
     
     