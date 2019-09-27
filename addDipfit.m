LoadingDir = '/Volumes/colin/conditionsEEG/';
EEGfiles = dir([LoadingDir,'*.set'])
for i = 1:length(EEGfiles)
    filename = EEGfiles(i).name;
EEG = pop_loadset('filename',filename,'filepath',LoadingDir);
EEG=pop_chanedit(EEG, 'lookup','/Users/lixiaomin/Documents/GitHub/eeg/plugins/dipfit/standard_BEM/elec/standard_1005.elc');
EEG = eeg_checkset( EEG );
EEG = pop_dipfit_settings( EEG, ...
    'hdmfile','/Users/lixiaomin/Documents/GitHub/eeg/plugins/dipfit/standard_BEM/standard_vol.mat',...
    'coordformat','MNI','mrifile','/Users/lixiaomin/Documents/GitHub/eeg/plugins/dipfit/standard_BEM/standard_mri.mat',...
'chanfile','/Users/lixiaomin/Documents/GitHub/eeg/plugins/dipfit/standard_BEM/elec/standard_1005.elc','coord_transform',...
[0 0 0 0 0 -1.5708 1 1 1] ,'chansel',[1:64]);
pop_saveset(EEG, 'filename',filename,'filepath',LoadingDir);
end
