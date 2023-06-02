potentials = ["1","3","4"];
path = "generatedData/training";
path2 = "generatedData/testing";
path3 = "generatedData/validation";
% image = reshape(eeg_fpz_orig(:,2), [50,60]);
files = dir(path);files(1:2) = [];
files2 = dir(path2);files2(1:2) = [];
files3 = dir(path3);files3(1:2) = [];
iterator = 1;

vals = dir("markers");vals(1:2) = [];

file = files(1).name;
filepath = sprintf('generatedData/training/%s',file);
fileName = 'labels.mat';
fpzName = 'fpz.mat';
eogName = 'eog.mat';
pzName = 'pz.mat';
fullpath = fullfile(filepath,fileName);
fullpath2 = fullfile(filepath,fpzName);
fullPath3 = fullfile(filepath,eogName);
fullPath4 = fullfile(filepath,pzName);
a = load(fullpath);
eegF = load(fullpath2);
eegE = load(fullPath3);
eegP = load(fullPath4);
imageFpz = eegF.eeg_fpz_orig;
imageEog = eegE.eog_orig;
imagePz = eegP.eeg_pz_orig;

fpz = reshape(imageFpz(:,1), [50,60]);
eog = reshape(imageEog(:,1), [50,60]);
pz = reshape(imagePz(:,1), [50,60]);

% image = struct('imageFpz',imageFpz, 'imagePz',imagePz, 'imageEog',imageEog);
% image = {imageFpz, imagePz,imageEog};

save('markers/image.mat',"fpz")
save('markers/image.mat',"pz", "eog",'-append')

% len = a.doubleArray;

% for i = 1:length(files)
%     file = files1(i).name;
%     filepath = sprintf('generatedData/testing/%s',file);
%     fileName = 'labels.mat';
%     eegName = 'fpz.mat';
%     fullpath = fullfile(filepath,fileName);
%     fullpath2 = fullfile(filepath,eegName);
%     a = load(fullpath);
%     eeg = load(fullpath2);
%     fpz = eeg.eeg_fpz_orig;
%     len = a.doubleArray;
%     for j = 1:length(len)-1
%         folder = num2str(len(j));
%         isElementInArray = ismember(folder, potentials);
%         if ~isElementInArray
%             continue
%         end 
%         image = reshape(fpz(:,j), [50,60]);
%         path = sprintf('markers/%s',folder);
%         name = sprintf("image%s.mat",num2str(iterator));
%         savePath = fullfile(path, name);
%         save(savePath, 'image');
%         iterator = iterator + 1;
%     end
%     disp(sprintf("finished file %s",file));
%     disp(iterator);
% end
