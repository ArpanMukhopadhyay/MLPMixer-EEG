path = "generatedData/training";
path2 = "generatedData/testing";
path3 = "generatedData/validation";
% 
files = dir(path);files(1:2) = [];
files2 = dir(path2);files2(1:2) = [];
files3 = dir(path3);files3(1:2) = [];

for i = 1:length(files)
    file = files(i).name;
    filepath = sprintf('generatedData/training/%s',file);
    fileName = 'hypnogram.mat';
    % Replace 'processSubfolder' with the code you want to execute on each subfolder
    fullpath = fullfile(filepath,fileName);
    a = load(fullpath);
    charArray = a.hypnogram_f;% your 1870x1 char array goes here
    doubleArray = str2double(cellstr(charArray)');
    doubleArray2 = str2double(cellstr(charArray));

    fullPath1 = fullfile(filepath, 'labels.mat');
    fullPath2 = fullfile(filepath, 'labels1.mat');
    save(fullPath1, 'doubleArray');
    save(fullPath2 ,'doubleArray2');

end

for i = 1:length(files2)
    file = files2(i).name;
    filepath = sprintf('generatedData/testing/%s',file);
    fileName = 'hypnogram.mat';
    % Replace 'processSubfolder' with the code you want to execute on each subfolder
    fullpath = fullfile(filepath,fileName);
    a = load(fullpath);
    charArray = a.hypnogram_f;% your 1870x1 char array goes here
    doubleArray = str2double(cellstr(charArray)');
    doubleArray2 = str2double(cellstr(charArray));

    fullPath1 = fullfile(filepath, 'labels.mat');
    fullPath2 = fullfile(filepath, 'labels1.mat');
    save(fullPath1, 'doubleArray');
    save(fullPath2 ,'doubleArray2');

end

% originalFileName = 'hypnogram.mat';
% newFileName = 'labels.mat';
% cd(path)

% Verify the size and type of the int array
% Rename the file