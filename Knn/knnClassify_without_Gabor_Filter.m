

% Training set location & 'No_Testset'
TrainingSet_add = 'F:\Matlab\new';
No_Testset      = 15;

 [TrainingSet_location, Train_label_Names, noFiles] = DirRead(TrainingSet_add,'*.jpg');
 
% Process Training set & Test set
 [TrainingSet,TestSet,train_label]  = SVM_datasets(TrainingSet_location, No_Testset,100, 100);

Training_Set=[];

for i=1:length(TrainingSet)
    Training_Set_tmp   = reshape(TrainingSet{i},1, 100*100);
    Training_Set=[Training_Set;Training_Set_tmp];
end

Test_Set=[];
for j=1:length(TestSet)
    Test_set_tmp   = reshape(TestSet{j},1, 100*100);
    Test_Set=[Test_Set;Test_set_tmp];
end
 
class = knnclassify(Test_Set, Training_Set, train_label)