% EEGLAB history file generated on the 28-Sep-2019
% ------------------------------------------------
[STUDY ALLEEG] = std_precomp(STUDY, ALLEEG, {},'savetrials','on','interp','on','recompute','on','erp','on','spec','on','specparams',{'specmode' 'fft' 'logtrials' 'off'},'erpim','on','erpimparams',{'nlines' 10 'smoothing' 10},'ersp','on','erspparams',{'cycles' [3 0.8]  'nfreqs' 100 'ntimesout' 200},'itc','on'); 
[ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'retrieve',[1:16] ,'study',1); CURRENTSTUDY = 1;
[STUDY ALLEEG] = std_precomp(STUDY, ALLEEG, 'components','savetrials','on','recompute','on','erp','on','scalp','on','spec','on','specparams',{'specmode' 'fft' 'logtrials' 'off'},'erpim','on','erpimparams',{'nlines' 10 'smoothing' 10},'ersp','on','erspparams',{'cycles' [3 0.8]  'nfreqs' 100 'ntimesout' 200},'itc','on');

