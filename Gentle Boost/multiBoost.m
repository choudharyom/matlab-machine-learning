function [result] = multiBoost(TrainingSet,GroupTrain,TestSet, varargin)


u=unique(GroupTrain);
numClasses=length(u);
result = zeros(length(TestSet(:,1)),1);

%build models
for k=1:numClasses
    %Vectorized statement that binarizes Group
    %where 1 is the current class and 0 is all other classes
    G1vAll=(GroupTrain==u(k));
    models = fitensemble(TrainingSet,G1vAll,varargin{:});
    p{k}= models;
end

%classify test cases
for j=1:size(TestSet,1)
    for k=1:numClasses
        if(predict(p{k},TestSet(j,:))) 
            break;
        end
    end
    result(j) = k;
end

