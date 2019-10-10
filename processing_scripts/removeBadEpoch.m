%% epoch the data, label conditions, clean epoches and clean artifact
marker = 1;
baseLineCri = [1000 1];
epochLength = [-1 2];
epochRejectCri = ['measure',[1,1,1],'z',[3,3,3]];%%modify here
EOG_chans = [];
%%epoch the data
inputFolder = '/Volumes/colin/tryNewPiple/';
datafile = dir([inputFolder,'*.set']);
SavingDir = '/Volumes/colin/tryNewPiple/';
for i = length(datafile)-1:length(datafile)
filename = datafile(i).name;
subId = str2num(filename(1:2));
EEG = pop_loadset('filename',filename,'filepath',inputFolder);
%% EPOCH
EEG = pop_epoch( EEG,{num2str(marker)},epochLength,'epochinfo','yes');
EEG = eeg_checkset(EEG);
EEG = pop_rmbase( EEG, baseLineCri,[]);

%% REJECT EPOCH
list_properties = epoch_properties(EEG,[1 64]);
[lengths] = min_z(list_properties,epochRejectCri);
EEG=pop_rejepoch(EEG, find(lengths),0);
fprintf('%.2f - Rejected %d epochs',toc,length(find(lengths)));

%% REJECT EOG
EOGlist_properties = component_properties(EEG,EOG_chans);
epochRejectCri.measure(2)=0;
[lengths] = min_z(list_properties,o.ica_options.rejection_options);
        bad_comps=find(lengths);
        if ~isempty(find(lengths,1))
            fprintf('Rejecting components');
            fprintf(' %d',find(lengths));
            fprintf('.\n');
            EEG = pop_subcomp(EEG, find(lengths), 0);
            else
            fprintf('Rejected no components.\n');
        end
%EEG = pop_saveset(EEG, 'filename',filename,'filepath',SavingDir);
%EEG = pop_loadset('filename',filename,'filepath',inputFolder);
end