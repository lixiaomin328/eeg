triggerId = 1;
subId = 15;
playerRole = 2;
playerRoleWords = {'b','a'};
[epochCondition1,epochCondition2,filename]=labelEpochCondition(triggerId,subId,playerRole);
LoadingDir = ['/Volumes/colin/outputTrigger',num2str(triggerId),'/',num2str(subId),playerRoleWords{playerRole},'/'];
EEG = pop_loadset('filename',filename,'filepath',LoadingDir);
EEG1 = EEG;
EEG2 = EEG;
EEG1.data  = EEG.data(:,:,epochCondition1);
EEG2.data = EEG.data(:,:,epochCondition2);
figure; 
pop_newtimef( EEG1,1,53,[-200 1000],[3 0.5],'topovec',53,'elocs',EEG1.chanlocs,...
'chaninfo',EEG1.chaninfo,'caption','TP8 middle card','baseline',[0],'alpha',0.05,'plotphase','off','padratio',1,'winsize',100);

figure; 
pop_newtimef( EEG2,1,53,[-200 1000],[3 0.5],'topovec',53,'elocs',EEG2.chanlocs,...
'chaninfo',EEG2.chaninfo,'caption','TP8 boundary card','baseline',[0],'alpha',0.05,'plotphase','off','padratio',1,'winsize',100);