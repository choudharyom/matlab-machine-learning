function [DirLoc, nameFolds, No_of_files, Name_of_files] = DirRead(Location, Extension )

% This function is specialy written for "SVM_datasets" function.
% This function checks if there exists another subdirectory.
% If there exists another dir then save the name and address
%----------------------------------------------------------
% Inputs:           Location
% Location          Path to the folder contaning the subfolder which has images
% Extension :       please use format like this '*.jpg'
%-----------------------------------------------------------
% Outputs:          DirLoc, No_of_files, Name_of_folders
% DirLoc            Full address of the subdirectory - Array
% No_of_files       Number of files in the directory
% nameFolds         Name of Folders or Training level is named accordingly
% incase if we are using it for my SVM_datasets specially.
% Name_of_files :   This will provide name of the files if there is no sub
% directory
% ----------------------------------------------------------

x=dir(Location);
isub        = [x(:).isdir];
nameFolds   = {x(isub).name}';
nameFolds(ismember(nameFolds,{'.','..'})) = [];

% If no subfolders then process all the files and save the names.
list = dir(Location);
isfile=~[list.isdir];
filenames={list(isfile).name};
Name_of_files = filenames.';

Dir_location=cell(length(nameFolds),1);
NoFiles = zeros(length(nameFolds),1);
    
    for i=1:length(nameFolds)
        Dir_location{i} = horzcat(Location,filesep,nameFolds{i});
        NoFiles(i)      = length(dir(horzcat(Dir_location{i},filesep,Extension)));
    end
    if isempty(Dir_location)
        DirLoc = Location;
        No_of_files = length(dir(horzcat(Location,filesep,Extension)));
    else
        DirLoc           = Dir_location;
        No_of_files      = NoFiles;
    end
end



