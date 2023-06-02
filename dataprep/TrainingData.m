clear; clc; close
d = dir('C:\Users\Saira\Desktop\usb\Sleep Net\SleepEDF\EDF Database\RecFiles');d(1:2) = [];
hyp_name = 'C:\Users\Saira\Desktop\usb\Sleep Net\SleepEDF\EDF Database\HypFiles\';
%save_path = 'D:\SleepEDF\MatlabCode\DatainMatFiles\';

save_path = 'D:\SleepEDF\MatlabCode\ThreeChannelsMatFiles\';
All_Data = [];ind = 1;
for i = 1:length(d)     
    file_name = d(i).name;
    [header, data]  = edfread([d(i).folder '\' file_name]);     
    tkn = strsplit(file_name,'.');
    [header_hyp, labels_orig]  = edfread([hyp_name tkn{1} '.hyp']);
    labels_orig(end) = [];     
    
    pzcz = data(1,1:(length(labels_orig)*3000));    
    pzoz = data(2,1:(length(labels_orig)*3000));    
    eog = data(3,1:(length(labels_orig)*3000));    
    
    
     pzcz_orig = reshape(pzcz, [3000 length(labels_orig)]);
     pzoz_orig = reshape(pzoz, [3000 length(labels_orig)]);
     eog_orig = reshape(eog, [3000 length(labels_orig)]);
     
     zr = zeros(25,size(pzoz_orig,2)); % to make 55x55 size
     pzcz_orig = [pzcz_orig;zr]; %first row are labels
     pzoz_orig = [pzoz_orig;zr]; %first row are labels
     eog_orig = [eog_orig;zr]; %first row are labels
    
    
    epochs_pzcz = [];
    epochs_pzoz = [];
    epochs_eog = [];
    labels = [];
    for lb = 0:5 % only stage 0 to 5 are required (Wake=0, 1=1,2=2,3=3,4=4,5=REM)
        a = (labels_orig==lb);         
        epochs_pzcz = ([epochs_pzcz pzcz_orig(:, a)]);
        epochs_pzoz = ([epochs_pzoz pzoz_orig(:, a)]);
        epochs_eog = ([epochs_eog eog_orig(:, a)]);
        labels = [labels labels_orig(a)]; 
    end
end 