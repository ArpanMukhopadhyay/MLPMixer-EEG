% data = rand(1000, 10); % Example data
% labels = randi([1, 3], 1000, 1); % Example labels (3 classes)
% 
% cv = cvpartition(length(labels), 'HoldOut', 0.3);
% idx_train = cv.training; % Logical index for training set
% idx_test_val = cv.test; % Logical index for testing + validation sets
% 
% % Further partition testing + validation sets into 50-50
% cv2 = cvpartition(length(idx_test_val), 'HoldOut', 0.5);
% idx_test = idx_test_val(cv2.training); % Logical index for testing set
% idx_val = idx_test_val(cv2.test); % Logical index for validation set
% 
% data_train = data(idx_train, :);
% labels_train = labels(idx_train);
% data_test = data(idx_test, :);
% labels_test = labels(idx_test);
% data_val = data(idx_val, :);
% labels_val = labels(idx_val);
% 
% disp(['Training set size: ', num2str(sum(idx_train))]);
% disp(['Testing set size: ', num2str(sum(idx_test))]);
% disp(['Validation set size: ', num2str(sum(idx_val))]);

% data = load('dataNew/SC4001/matlab/eeg_fpz.mat');
% 
% % Extract the variables from the data struct
% variable1 = data.variable1;
% variable2 = data.variable2;
s = sprintf('./dataNew/ST7242');
[all_data, f_samp, number_of_epochs, hypnogram_f, times ] = loadEDFx(s,'RK');
disp(all_data.keys)
fpz = all_data('eeg_fpz');
pz = all_data('eeg_pz');
eo = all_data('eog_horizontal');

eeg_fpz = fpz(1:(length(hypnogram_f)*3000));
eeg_pz = pz(1:(length(hypnogram_f)*3000));
eog = eo(1:(length(hypnogram_f)*3000));

eeg_fpz_orig = reshape(eeg_fpz, [3000 length(hypnogram_f)]);
eeg_pz_orig = reshape(eeg_pz, [3000 length(hypnogram_f)]);
eog_orig = reshape(eog, [3000 length(hypnogram_f)]);

% folder_path = './generatedData/training';
% path = 'ST7242';
% newPath = sprintf('./generatedData/training/%s',path);
% mkdir(newPath)
% filename1 = 'fpz.mat';
% filename2 = 'pz.mat';
% filename3 = 'eog.mat';
% filename4 = 'hypnogram.mat';
% 
% fullPath1 = fullfile(newPath, filename1);
% fullPath2 = fullfile(newPath, filename2);
% fullPath3 = fullfile(newPath, filename3);
% fullPath4 = fullfile(newPath, filename4);
% 
% save(fullPath1, 'eeg_fpz_orig');
% save(fullPath2 ,'eeg_pz_orig');
% save(fullPath3 ,'eog_orig');
% save (fullPath4 ,'hypnogram_f');
% 
 % zr = zeros(25,size(eeg_pz_orig,2)); % to make 55x55 size
 % eeg_fpz_orig = [eeg_fpz_orig;zr]; %first row are labels
 % eeg_pz_orig = [eeg_pz_orig;zr]; %first row are labels
 % eog_orig = [eog_orig;zr]; %first row are labels
% 
% epochs_pzcz = [];
% epochs_pzoz = [];
% epochs_eog = [];
% labels = [];
% 
% for lb = 0:5 % only stage 0 to 5 are required (Wake=0, 1=1,2=2,3=3,4=4,5=REM)
%     a = hypnogram_f;
%     disp(hypnogram_f)
%     epochs_pzcz = ([epochs_pzcz eeg_fpz_orig(:, a)]);
%     epochs_pzoz = ([epochs_pzoz eeg_pz_orig(:, a)]);
%     epochs_eog = ([epochs_eog eog_orig(:, a)]);
%     labels = [labels hypnogram_f]; 
% end


