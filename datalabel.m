path = "generatedData/training";
path2 = "generatedData/testing";
path3 = "generatedData/validation";
% image = reshape(eeg_fpz_orig(:,2), [50,60]);
files = dir(path);files(1:2) = [];
files2 = dir(path2);files2(1:2) = [];
files3 = dir(path3);files3(1:2) = [];
iterator = 1;

iterator0 = 1;
iterator1 = 1;
iterator2 = 1;
iterator3 = 1;
iterator4 = 1;
iterator5 = 1;
potentials = ["0","1","2","3","4","5"];

for i = 1:length(files)
    file = files(i).name;
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
    len = a.doubleArray;
    for j = 1:length(len)-1
        folder = num2str(len(j));
        isElementInArray = ismember(folder, potentials);
        if ~isElementInArray
            continue
        end
        if len(j) == 0
            if iterator0 == 7000
                continue
            else
                iterator0 = iterator0 + 1;
            end
        elseif len(j) == 1
            if iterator1 == 7000
                continue
            else
                iterator1 = iterator1 + 1;
            end
        elseif len(j) == 2
            if iterator2 == 7000
                continue
            else
                iterator2 = iterator2 + 1;                
            end 
        elseif len(j) == 3
            if iterator3 == 7000
                continue
            else
                iterator3 = iterator3 + 1;                
            end
        elseif len(j) == 4
            if iterator4 == 7000
                continue
            else
                iterator4 = iterator4 + 1;                
            end 
        elseif len(j) == 5
            if iterator5 == 7000
                continue
             else
                iterator5 = iterator5 + 1;               
            end 
        end
        fpz = reshape(imageFpz(:,j), [50,60]);
        eog = reshape(imageEog(:,j), [50,60]);
        pz = reshape(imagePz(:,j), [50,60]);
        path = sprintf('markers/%s',folder);
        name = sprintf("image%s.mat",num2str(iterator));
        savePath = fullfile(path, name);
        save(savePath, 'fpz');
        save(savePath,"pz", "eog",'-append')
        iterator = iterator + 1;
    end
    val = sprintf("finished file %s",file);
    disp(val);
    disp(iterator);
end

for i = 1:length(files2)
     file = files2(i).name;
    filepath = sprintf('generatedData/testing/%s',file);
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
    len = a.doubleArray;
    for j = 1:length(len)-1
        folder = num2str(len(j));
        isElementInArray = ismember(folder, potentials);
        if ~isElementInArray
            continue
        end
        if len(j) == 0
            if iterator0 == 7000
                continue
            else
                iterator0 = iterator0 + 1;
            end
        elseif len(j) == 1
            if iterator1 == 7000
                continue
            else
                iterator1 = iterator1 + 1;
            end
        elseif len(j) == 2
            if iterator2 == 7000
                continue
            else
                iterator2 = iterator2 + 1;                
            end 
        elseif len(j) == 3
            if iterator3 == 7000
                continue
            else
                iterator3 = iterator3 + 1;                
            end
        elseif len(j) == 4
            if iterator4 == 7000
                continue
            else
                iterator4 = iterator4 + 1;                
            end 
        elseif len(j) == 5
            if iterator5 == 7000
                continue
             else
                iterator5 = iterator5 + 1;               
            end 
        end
        fpz = reshape(imageFpz(:,j), [50,60]);
        eog = reshape(imageEog(:,j), [50,60]);
        pz = reshape(imagePz(:,j), [50,60]);
        path = sprintf('markers/%s',folder);
        name = sprintf("image%s.mat",num2str(iterator));
        savePath = fullfile(path, name);
        save(savePath, 'fpz');
        save(savePath,"pz", "eog",'-append')
        iterator = iterator + 1;
    end
    val = sprintf("finished file %s",file);
    disp(val);
    disp(iterator);
end

for i = 1:length(files3)
    file = files3(i).name;
    filepath = sprintf('generatedData/validation/%s',file);
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
    len = a.doubleArray;
    for j = 1:length(len)-1
        folder = num2str(len(j));
        isElementInArray = ismember(folder, potentials);
        if ~isElementInArray
            continue
        end
        if len(j) == 0
            if iterator0 == 7000
                continue
            else
                iterator0 = iterator0 + 1;
            end
        elseif len(j) == 1
            if iterator1 == 7000
                continue
            else
                iterator1 = iterator1 + 1;
            end
        elseif len(j) == 2
            if iterator2 == 7000
                continue
            else
                iterator2 = iterator2 + 1;                
            end 
        elseif len(j) == 3
            if iterator3 == 7000
                continue
            else
                iterator3 = iterator3 + 1;                
            end
        elseif len(j) == 4
            if iterator4 == 7000
                continue
            else
                iterator4 = iterator4 + 1;                
            end 
        elseif len(j) == 5
            if iterator5 == 7000
                continue
             else
                iterator5 = iterator5 + 1;               
            end 
        end
        fpz = reshape(imageFpz(:,j), [50,60]);
        eog = reshape(imageEog(:,j), [50,60]);
        pz = reshape(imagePz(:,j), [50,60]);
        path = sprintf('markers/%s',folder);
        name = sprintf("image%s.mat",num2str(iterator));
        savePath = fullfile(path, name);
        save(savePath, 'fpz');
        save(savePath,"pz", "eog",'-append')
        iterator = iterator + 1;
    end
    val = sprintf("finished file %s",file);
    disp(val);
    disp(iterator);
end


