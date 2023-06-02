parentFolder = '/Users/arpanmukhopadhyay/Documents/EEG topics/sleep-edfx-toolbox-master/dataNew';

% Use the 'dir' function to get a list of all files and subfolders in the parent folder
files = dir(parentFolder);files(1:2) = []; 
% Loop over each file and subfolder in the parent folder
num_files = length(files);
training = round(num_files * 0.7);
testing = training + round(num_files * 0.2);
valid = testing + round(num_files * 0.1);

for i = 1:length(files)
    % name = files(i).name;
    % fprintf(name);
    % path = sprintf('%s/matlab',name);
    % if path
    %     fprintf('yes')
    % end
    if files(i).isdir && ~strcmp(files(i).name,'.') && ~strcmp(files(i).name,'..')
        % If the current file is a subfolder, process it
        subfolderName = files(i).name;
        fprintf(i)
        % Replace 'processSubfolder' with the code you want to execute on each subfolder
        s = sprintf('./dataNew/%s',subfolderName);
        [all_data, f_samp, number_of_epochs, hypnogram_f, times ] = loadEDFx(s,'RK');
        fpz = all_data('eeg_fpz');
        pz = all_data('eeg_pz');
        eo = all_data('eog_horizontal');

        eeg_fpz = fpz(1:(length(hypnogram_f)*3000));
        eeg_pz = pz(1:(length(hypnogram_f)*3000));
        eog = eo(1:(length(hypnogram_f)*3000));

        eeg_fpz_orig = reshape(eeg_fpz, [3000 length(hypnogram_f)]);
        eeg_pz_orig = reshape(eeg_pz, [3000 length(hypnogram_f)]);
        eog_orig = reshape(eog, [3000 length(hypnogram_f)]);
        if i <= training
            folder_path = './generatedData/training';
            path = subfolderName;
            newPath = sprintf('./generatedData/training/%s',path);
            mkdir(newPath)
            filename1 = 'fpz.mat';
            filename2 = 'pz.mat';
            filename3 = 'eog.mat';
            filename4 = 'hypnogram.mat';
            
            fullPath1 = fullfile(newPath, filename1);
            fullPath2 = fullfile(newPath, filename2);
            fullPath3 = fullfile(newPath, filename3);
            fullPath4 = fullfile(newPath, filename4);
            
            save(fullPath1, 'eeg_fpz_orig');
            save(fullPath2 ,'eeg_pz_orig');
            save(fullPath3 ,'eog_orig');
            save (fullPath4 ,'hypnogram_f');
        elseif i >= training && i <= testing
            folder_path = './generatedData/testing';
            path = subfolderName;
            newPath = sprintf('./generatedData/testing/%s',path);
            mkdir(newPath)
            filename1 = 'fpz.mat';
            filename2 = 'pz.mat';
            filename3 = 'eog.mat';
            filename4 = 'hypnogram.mat';
            
            fullPath1 = fullfile(newPath, filename1);
            fullPath2 = fullfile(newPath, filename2);
            fullPath3 = fullfile(newPath, filename3);
            fullPath4 = fullfile(newPath, filename4);
            
            save(fullPath1, 'eeg_fpz_orig');
            save(fullPath2 ,'eeg_pz_orig');
            save(fullPath3 ,'eog_orig');
            save (fullPath4 ,'hypnogram_f');
        else
            folder_path = './generatedData/validation';
            path = subfolderName;
            newPath = sprintf('./generatedData/validation/%s',path);
            mkdir(newPath)
            filename1 = 'fpz.mat';
            filename2 = 'pz.mat';
            filename3 = 'eog.mat';
            filename4 = 'hypnogram.mat';
            
            fullPath1 = fullfile(newPath, filename1);
            fullPath2 = fullfile(newPath, filename2);
            fullPath3 = fullfile(newPath, filename3);
            fullPath4 = fullfile(newPath, filename4);
            
            save(fullPath1, 'eeg_fpz_orig');
            save(fullPath2 ,'eeg_pz_orig');
            save(fullPath3 ,'eog_orig');
            save (fullPath4 ,'hypnogram_f');
        end
    end
end

% function p = processSubfolder(a)
%     fprintf(a);
% end