clc
clear all

% Set constants
f             = 5.5/24;           % Frequency
halfSDsq      = 3/( 2*pi*f*24 );  % Sigma
gamma         = 0.75;
phases        = 2;
ori           = 4;                %orientation

% Hard coded filter properties
kernelSize    = 11;               % Windowsize

% Training set location & no of test image to use per class
TrainingSet_add = 'F:\101_ObjectCategories';
No_Testset      = 50;
No_Trainset     = 15;

% Process the Training set location
 TrainingSet_location = DirRead(TrainingSet_add,'*.jpg');
 
% Prepare Training set & Test set
 [TrainingSet,TestSet,train_label]  = SVM_datasets(TrainingSet_location,No_Trainset, No_Testset,140, 140);

% Apply Gabour Filter to Training set & Testset images
 Training_Set = ImgGabor(TrainingSet, kernelSize, ori, phases, gamma, f, halfSDsq);
 TestSet      = ImgGabor(TestSet, kernelSize, ori, phases, gamma, f, halfSDsq);

% Train the classifier
PredictedLabels     = multisvm(TrainingSet,train_label,TestSet,'kernel_function','linear','boxconstraint',2,'kktviolationlevel',0.1,'kernelcachelimit',10000,'options',statset('MaxIter',1000000));
