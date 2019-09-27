% EEGLAB history file generated on the 26-Sep-2019
% ------------------------------------------------

EEG.etc.eeglabvers = 'development head'; % this tracks which version of EEGLAB is being used, you may ignore it
EEG = pop_biosig('/Users/xiaominli/Google Drive/EEG POKEr/10.bdf');
EEG.setname='10BDF file';
EEG = eeg_checkset( EEG );
EEG = pop_saveset( EEG, 'filename','10.set','filepath','/Users/xiaominli/Google Drive/EEG POKEr/');
EEG = eeg_checkset( EEG );
EEG = eeg_checkset( EEG );
EEG = pop_select( EEG, 'channel',{'2-A1' '2-A2' '2-A3' '2-A4' '2-A5' '2-A6' '2-A7' '2-A8' '2-A9' '2-A10' '2-A11' '2-A12' '2-A13' '2-A14' '2-A15' '2-A16' '2-A17' '2-A18' '2-A19' '2-A20' '2-A21' '2-A22' '2-A23' '2-A24' '2-A25' '2-A26' '2-A27' '2-A28' '2-A29' '2-A30' '2-A31' '2-A32' '2-B1' '2-B2' '2-B3' '2-B4' '2-B5' '2-B6' '2-B7' '2-B8' '2-B9' '2-B10' '2-B11' '2-B12' '2-B13' '2-B14' '2-B15' '2-B16' '2-B17' '2-B18' '2-B19' '2-B20' '2-B21' '2-B22' '2-B23' '2-B24' '2-B25' '2-B26' '2-B27' '2-B28' '2-B29' '2-B30' '2-B31' '2-B32'});
EEG.setname='10bBDF file';
EEG = pop_loadset('filename','10b.set','filepath','/Volumes/colin/EEG_data/');
EEG = eeg_checkset( EEG );
EEG = pop_editeventvals(EEG,'delete',1);
EEG = eeg_checkset( EEG );
EEG = eeg_checkset( EEG );
EEG = eeg_checkset( EEG );
EEG=pop_chanedit(EEG, 'lookup','/Users/lixiaomin/Documents/GitHub/eeg/plugins/dipfit/standard_BEM/elec/standard_1005.elc');
EEG = eeg_checkset( EEG );
EEG = pop_dipfit_settings( EEG, 'hdmfile','/Users/lixiaomin/Documents/GitHub/eeg/plugins/dipfit/standard_BEM/standard_vol.mat','coordformat','MNI','mrifile','/Users/lixiaomin/Documents/GitHub/eeg/plugins/dipfit/standard_BEM/standard_mri.mat','chanfile','/Users/lixiaomin/Documents/GitHub/eeg/plugins/dipfit/standard_BEM/elec/standard_1005.elc','coord_transform',[0 0 0 0 0 -1.5708 1 1 1] ,'chansel',[1:64] );
