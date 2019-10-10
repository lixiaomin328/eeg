%% settings overall 
SavingDir = '/Volumes/colin/cleanResampled';
LoadingDir = '/Volumes/colin/eegResampled/';
eegFiles = dir([LoadingDir,'*.set']);
highPass = 1;
%% settings for clean.m
arg_flatline = -1;
arg_highpass =-1;
arg_channel=0.8; 
arg_noisy=-1; 
arg_burst=8; 
arg_window=0.25; 
optionalInputCells=cell(0,0);
numberOfChans =64;
lineFreLow=60;
lineFreHigh = 120;
pValue=0.01;
tau = 100;
winsize = 4;
winstep = 1;
%% high pass filter and channel locations
for subId = 1:length(eegFiles)
filename = eegFiles(subId).name;
EEG = pop_loadset('filename',filename,'filepath',LoadingDir);
EEG = pop_resample(EEG,256);
EEG = eeg_checkset(EEG);
EEG = pop_eegfilt( EEG,highPass,0,[], [0], 0, 0, 'fir1', 0);
EEG = eeg_checkset( EEG );
EEG=pop_chanedit(EEG, 'lookup','/Users/xiaominli/Documents/eeg/plugins/dipfit/standard_BEM/elec/standard_1005.elc','load',{'/Users/xiaominli/Documents/eeg/Biosemi64.elp' 'filetype' 'autodetect'});
EEG = eeg_checkset( EEG );
EEG = pop_cleanline(EEG, 'bandwidth',2,'chanlist',[1:numberOfChans] ,'computepower',0,...
    'linefreqs',[lineFreLow lineFreHigh] ,'normSpectrum',0,'p',pValue,'pad',2,'plotfigures',0,'scanforlines',1,...
    'sigtype','Channels','tau',tau,'verb',1,'winsize',winsize,'winstep',winstep);
originalEEG= EEG;
cleanEEG = clean_rawdata(EEG, arg_flatline, arg_highpass, arg_channel, ...
arg_noisy, arg_burst, arg_window, optionalInputCells);
%% Update EEG.
cleanEEG.nbchan
EEG = pop_interp(cleanEEG, originalEEG.chanlocs, 'spherical');
% Output eegh.
com = EEG.etc.clean_rawdata_log;
EEG = eegh(com, EEG);
% Update EEG.
EEG.etc.clean_rawdata_log = com;
assignin('base', 'EEG', EEG);
%% re-reference to average
EEG = pop_reref( EEG, []);
%% ICA
EEG = pop_runica(EEG, 'icatype', 'runica', 'extended',1,'interrupt','on');

%%
EEG = pop_saveset(EEG,'filename',filename,'filepath',SavingDir);
fprintf(['Done for ',num2str(subId)])
end