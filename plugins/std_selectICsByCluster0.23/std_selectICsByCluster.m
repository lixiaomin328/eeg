% std_selectICsByCluster()-This function is to select STUDY cluster-selected ICs
%                to each subject's channels. To calculate forward-projected ERPs,
%                it uses channels that are common across all subjects
%                in the STUDY. Optionally, users can save the .set files
%                that have only selected and selectICsByClusterected ICs.
%                Use this function after loading STUDY.
% 
% LIMITATION  -  Within-subject conditions should be contained in a single .set file
%                (i.e. do not separate .set files for each condition!)
%                Two within-subject conditions not supported.
%
% Usage:
%       std_selectICsByCluster(STUDY, ALLEEG, EEG, clustInclude, clustExclude, savePath);
% 
%       Outputs are available in STUDY as it directly 'assignin' STUDY in the 'base'.  
%       This function is called by std_pop_selectICsByCluster()
%
% Inputs:
%       STUDY - EEGLAB STUDY. 
%       ALLEEG - EEGLAB ALLEEG.
%       EEG - EEGLAB EEG.
%       clustInclude - Index numbers of STUDY clusters for selectICsByClusterection. [integer(s)]
%       clustExclude - Index numbers of STUDY clusters to exclude from pvaf calculation. [integer(s)]
%       savePath - Optional. If provided, save new .set files with selected ICs as '(old_finename)_selectICsByCluster'. 
%       createClusterSelectedICs - Whether to create STUDY.selectICsByCluster. [Default: 1]
%
% Outputs:
%       These are stored under STUDY.selectICsByCluster
%       includeIcList - Columns are [index in ALLEEG, IC index in the dataset, cluster index, group index]
%       excludeIcList - Same as above.
%       subjectList - List of the datasets included in the 'includeIcList'.
%       latencyInMillisecond - Same as EEG.times
%       selectICsByClusterErp - dimensions are [channels, latency, datasetIndex, group(if any)]
%       outermostEnv - dimensions are [outermostEnvelopes, latency, datasetIndex, group(if any)]
%       selectICsByClusterEnv - dimensions are [selectICsByClusterectedEnvelopes, latency, datasetIndex, group(if any)]
%       erpPvaf - dimensions are [latency, datasetIndex]
%       channelList - channel names that are common across all the datasets submitted
%       betweenSubjectCondition (if 'group' is present) - levels of the groups selected in the current design
%       groupList (if 'group' is present) - dataset group index list
%       withinSubjectCondition (if it is present) - levels of the within-subject conditions selected in the current design
%       lastExportData (if data are exported) - columns are [latency,allSubjectsERP]/[latency,outermostEnvelope,selectICsByClusterectedEnvelope,pvaf] To compute the mean pvaf, average pvaf (6th column).

% Author: Makoto Miyakoshi JSPS/SCCN,INC,UCSD
% History:
% 05/27/2016 ver 0.36 by Makoto. When save path is provided, skip checking common channels across subjects.
% 01/07/2016 ver 0.35 by Makoto. Minor bug fixed. ERP exported are from all subjects.
% 05/22/2015 ver 0.34 by Makoto. Renamed the function.
% 04/22/2015 ver 0.33 by Makoto. Session (i.e. within-subject but different ICA) supported.
% 01/19/2015 ver 0.32 by Makoto. ERP channel order fixed. Depricated functions replaced.
% 01/14/2015 ver 0.31 by Makoto. Outermost envelope consistes of ICs included in the STUDY. latency range selection improved.
% 01/05/2015 ver 0.30 by Makoto. Major renewal upon the request by Jens Bernhardsson. Automatically selects all channels available. erpPvaf is stored with full latency frames.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 03/04/2014 ver 7.1 by Makoto. [] in the input box for the cluster number removed.
% 02/27/2014 ver 7.0 by Makoto. pop_selectevent -> pop_epoch (thanks to Lizzy Blundon). Available channel list output added. pvaf topo & channel added.
% 02/05/2014 ver 6.4 by Makoto. Help button added. Limitation and caution added.
% 06/28/2013 ver 6.3 by Makoto. Added fprintf('Saved %s/%s_selectICsByCluster\n', pwd, dataName)
% 06/18/2013 ver 6.2 by Makoto. Clear STUDY.selectICsByCluster timing optimized.
% 01/28/2013 ver 6.1 by Makoto. Combined conditions supported.
% 01/17/2013 ver 6.0 by Makoto. Bug fixed (thanks to Anthony Rissling).
% 01/04/2013 ver 5.1 by Makoto. Help added.
% 01/04/2013 ver 5.0 by Makoto. Handles multi-channel multi-cluser requests. Backprojected dataset can be saved.
% 10/26/2012 ver 4.0 by Makoto. Renewed for a plugin.
% 10/24/2012 ver 3.2 by Makoto. clear tmp actualindex added.
% 10/23/2012 ver 3.1 by Makoto. icList included in the final output. icList1 now refers to STUDY.design.
% 10/12/2012 ver 3.0 by Makoto. Multiple cluster selectICsByClusterection supported
% 07/12/2012 ver 2.0 by Makoto. Serious bug fixed (channel number was used for IC indICes!) 
% 07/10/2012 ver 1.0 by Makoto. Test version created.

% Copyright (C) 2012 Makoto Miyakoshi JSPS/SCCN,INC,UCSD
%
% This program is free software; you can redistribute it and/or modify
% it under the terms of the GNU General PublIC LICense as published by
% the Free Software Foundation; either version 2 of the LICense, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General PublIC LICense for more details.
%
% You should have received a copy of the GNU General PublIC LICense
% along with this program; if not, write to the Free Software
% Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1.07  USA

function std_selectICsByCluster(STUDY, ALLEEG, EEG, clustInclude, clustExclude, savePath)

%%%%%%%%%%%%%%%%%%%
%%% input check %%%
%%%%%%%%%%%%%%%%%%%
if isempty(clustInclude)
    error('Enter the cluster numbers to selectICsByClusterect.')
end

if isempty(savePath)
    disp('No save path provided: New .set files will NOT be created.')
else
    disp(['Save path provided: New .set files will be created under ' savePath])
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Obtain cluster indices to include and exclude. %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Obtain cluster indices to include and exclude.
if isempty(clustExclude)
    clustExclude = 0;
end
clustUse = nonzeros([clustInclude clustExclude])';



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Find common channels available across all subjects. %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Skip this process when save path is specified. (05/27/2016 Makoto)
if isempty(savePath)
    for n = 1:length(ALLEEG)-1
        if n == 1
            commonChanList = {ALLEEG(1,n).chanlocs.labels};
        end
        currentChanList = {ALLEEG(1,n+1).chanlocs.labels};
        commonChanList  = intersect(commonChanList, currentChanList);
        if isempty(commonChanList)
            error('No common channel!')
        end
    end
    disp(sprintf('%d channels are commonly available across all datasets.',length(commonChanList)))
    clear currentChanList

    % Obtain the original channel order because commonChanList is SORTED:
    % find the dataset that has the most channels.
    for n = 1:length(ALLEEG)
        numChanList(n,1) = length(ALLEEG(1,n).chanlocs);
    end
    [~,maxChanSetIdx] = max(numChanList);
    largestChanlocs = ALLEEG(1,maxChanSetIdx).chanlocs;
    mostChanList = {largestChanlocs.labels};
    
    survivedChanIdx = ismember(mostChanList, commonChanList);
    selectICsByClusterChan = mostChanList(1,survivedChanIdx);
    clear commonChanList commonChan largestChanlocs maxChanSetIdx mostChanList numChanList
else
    selectICsByClusterChan = 'noChannelSelected';
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Delete old STUDY.selectICsByCluster variables. %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if isfield(STUDY, 'selectICsByCluster')
    STUDY = rmfield(STUDY, 'selectICsByCluster');
    disp('Old STUDY.selectICsByCluster is deleted for new results.')
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Create subj & IC list: no group or session. %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
designLabel = {STUDY.design(STUDY.currentdesign).variable.label};
groupFieldIdx = find(strcmp(designLabel, 'group')|strcmp(designLabel, 'session'));
if isempty(groupFieldIdx)
    % pre-allocate memory
    perGroupLength = 0;
    for clust = 1:length(clustUse)
        tmpLength = length(STUDY.cluster(1,clustUse(clust)).setinds{1,1});
        perGroupLength = perGroupLength + tmpLength;
    end
    allSetIc = zeros(perGroupLength, 3);
    
    % extract indices for setfiles and ICs
    listCounter = 0;
    for clust = 2:length(STUDY.cluster) % skip the Parent cluster
        tmpSetInd = STUDY.cluster(1,clust).setinds{1,1};
        for m = 1:length(tmpSetInd)
            listCounter = listCounter+1;
            allSetIc(listCounter,1) = STUDY.design(STUDY.currentdesign).cell(tmpSetInd(1,m)).dataset; %#ok<*AGROW> % dataset number
            allSetIc(listCounter,2) = STUDY.cluster(1,clust).allinds{1,1}(1,m); % IC number
            allSetIc(listCounter,3) = clust; % cluster number
        end
    end
    
    % sort the results into the order of the setfile index
    tmpSetInd    = allSetIc(:,1);
    [~,sortIndex] = sort(tmpSetInd);
    allIcList = [allSetIc(sortIndex,:) repmat(1, [length(tmpSetInd) 1])]; % allSetIc_sorted == [subjID IC cluster group];
    
    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Create subj & IC list: with group or session. %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
else
    % detect 'group' or 'session' in the STUDY.design.variable
    STUDY.selectICsByCluster.betweenSubjectCondition = STUDY.design(STUDY.currentdesign).variable(1,groupFieldIdx).value;
    
    % pre-allocate memory: one cannot use length(STUDY.group) because they may be combined by user
    if groupFieldIdx == 1
        combinedGroupValue = STUDY.design(STUDY.currentdesign).variable(1,1).value;
    else
        combinedGroupValue = STUDY.design(STUDY.currentdesign).variable(1,2).value;
    end
    perGroupLength = zeros(1, length(combinedGroupValue));
    
    for group = 1:length(combinedGroupValue)
        for clust = 1:length(clustUse)
            switch groupFieldIdx
                case 1
                    tmpLength = length(STUDY.cluster(1,clustUse(clust)).setinds{group,1});
                case 2
                    tmpLength = length(STUDY.cluster(1,clustUse(clust)).setinds{1,group});
            end
            perGroupLength(1,group) = perGroupLength(1,group) + tmpLength;
        end
    end
    for group = 1:length(combinedGroupValue)
        allSetIc{1,group} = zeros(perGroupLength(1,group), 3);
    end
    
    % extract indices for ALL ICs included
    for group = 1:length(combinedGroupValue)
        listCounter = 0;
        for clust = 2:length(STUDY.cluster) % skip the Parent cluster
            switch groupFieldIdx
                case 1
                    tmpSetInd = STUDY.cluster(1,clust).setinds{group,1};
                case 2
                    tmpSetInd = STUDY.cluster(1,clust).setinds{1,group};
            end
            for m = 1:length(tmpSetInd)
                listCounter = listCounter+1;
                allSetIc{1,group}(listCounter,1) = STUDY.design(STUDY.currentdesign).cell(tmpSetInd(m)).dataset; %#ok<*AGROW> % dataset number
                switch groupFieldIdx
                    case 1
                        allSetIc{1,group}(listCounter,2) = STUDY.cluster(1,clust).allinds{group,1}(1,m); % IC number
                    case 2
                        allSetIc{1,group}(listCounter,2) = STUDY.cluster(1,clust).allinds{1,group}(1,m); % IC number
                end
                allSetIc{1,group}(listCounter,3) = clust; % cluster number
            end
        end
    end
    for group = 1:length(combinedGroupValue)
        tmpSetInd    = allSetIc{1,group}(:,1);
        [~,sortIndex] = sort(tmpSetInd);
        allSetIc{1,group} = allSetIc{1,group}(sortIndex,:);
        tmpList = [allSetIc{1,group} repmat(group, [length(allSetIc{1,group}) 1])];
        % allSetIc_sorted == [subjID IC cluster group];
        if group == 1
            allIcList = tmpList;
        else
            allIcList = [allIcList; tmpList];
        end
    end
    clear allSetIc
end
STUDY.selectICsByCluster.allIcList = allIcList;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Calculate unique subjects. %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
includeIcIdx  = find(ismember(allIcList(:,3),clustInclude));
includeIcList = allIcList(includeIcIdx,:);
STUDY.selectICsByCluster.includeIcList = includeIcList;

if any(clustExclude)
    excludeIcSubjIdx = find(ismember(allIcList(:,3),clustExclude));
    excludeIcList    = allIcList(excludeIcSubjIdx,:);
    STUDY.selectICsByCluster.excludeIcList = excludeIcList;
end
clear excludeIcIdx

[~,uniqueSubjIdx] = unique(includeIcList(:,1));
uniqueSubj = includeIcList(uniqueSubjIdx,:);
uniqueSubj = uniqueSubj(:,[1 3]); % uniquesubj = [setfileIdx clusterIdx]
STUDY.selectICsByCluster.subjectList   = {ALLEEG(uniqueSubj(:,1)).setname}';
STUDY.selectICsByCluster.latencyInMillisecond = ALLEEG(1,1).times;
if any(groupFieldIdx)
    STUDY.selectICsByCluster.groupList = includeIcList(uniqueSubjIdx,4);
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Process each subject. %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
waitBarHandle = waitbar(0,'Selecting ICs...');
waitBarCount  = 0;

% Check STUDY variables.
withinSubjectConditionPresent = [any(designLabel{1,1}) & ~(strcmp(designLabel{1,1},'group')|strcmp(designLabel{1,1},'session')) any(designLabel{1,2}) & ~(strcmp(designLabel{1,2},'group')|strcmp(designLabel{1,2},'session'))];

% Store selectICsByClusterection channel.
STUDY.selectICsByCluster.channelList = selectICsByClusterChan;

% Pre-allocate memory: when there is within-subject condition.
if isempty(savePath)
    if any(sum(withinSubjectConditionPresent))
        conditionLabelsCell = STUDY.design(STUDY.currentdesign).variable(find(withinSubjectConditionPresent)).value;
        STUDY.selectICsByCluster.withinSubjectCondition = conditionLabelsCell;
        withinSubjectConditionLabel                     = STUDY.design(STUDY.currentdesign).variable(find(withinSubjectConditionPresent)).label;
        withinSubjectConditionNum                       = length(conditionLabelsCell);
        
        STUDY.selectICsByCluster.outermostEnv          = single(zeros(2, length(ALLEEG(1,1).times), length(uniqueSubj), withinSubjectConditionNum));
        STUDY.selectICsByCluster.selectICsByClusterEnv = single(zeros(2, length(ALLEEG(1,1).times), length(uniqueSubj), withinSubjectConditionNum));
        STUDY.selectICsByCluster.erpPvaf               = single(zeros(length(ALLEEG(1,1).times), length(uniqueSubj), withinSubjectConditionNum));
        STUDY.selectICsByCluster.selectICsByClusterErp = single(zeros(length(selectICsByClusterChan),length(ALLEEG(1,1).times), length(uniqueSubj), withinSubjectConditionNum));
        STUDY.selectICsByCluster.icaact                = single(zeros(length(selectICsByClusterChan),length(ALLEEG(1,1).times), length(uniqueSubj), withinSubjectConditionNum));
        
    % Pre-allocate memory: when if there is NO within-subject condition
    else
        STUDY.selectICsByCluster.outermostEnv          = single(zeros(2, length(ALLEEG(1,1).times), length(uniqueSubj)));
        STUDY.selectICsByCluster.selectICsByClusterEnv = single(zeros(2, length(ALLEEG(1,1).times), length(uniqueSubj)));
        STUDY.selectICsByCluster.erpPvaf               = single(zeros(length(ALLEEG(1,1).times), length(uniqueSubj)));
        STUDY.selectICsByCluster.selectICsByClusterErp = single(zeros(length(selectICsByClusterChan),length(ALLEEG(1,1).times), length(uniqueSubj)));
        STUDY.selectICsByCluster.icaact                = single(zeros(length(selectICsByClusterChan),length(ALLEEG(1,1).times), length(uniqueSubj)));
    end
end

% Process each subject.
for n = 1:length(uniqueSubj)
    
    % Update the waitbar.
    waitBarCount = waitBarCount+1;
    waitbar(waitBarCount/size(uniqueSubj,1), waitBarHandle)
    
    % Load subject data & convert double to single.
    [~, EEG]   = pop_newset(ALLEEG, EEG, 1, 'retrieve', uniqueSubj(n,1), 'study', 1);
    EEG.data   = single(EEG.data);
    EEG.icaact = [];
    
    % Check data dimensions.
    if size(EEG.data)<=2
        error('EEG data must be epoched.')
    end
    
    % Calculate the inner envelope.
    innerEnvSubjIdx  = find(includeIcList(:,1)==uniqueSubj(n,1));
    icToKeepInnerEnv = includeIcList(innerEnvSubjIdx,2);
    EEG_innerEnv     = pop_subcomp(EEG, setdiff([1:size(EEG.icaweights,1)], icToKeepInnerEnv), 0);
    EEG_innerEnv     = eeg_checkset(EEG_innerEnv, 'ica');

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%% Save the current subject with selected ICs. %%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if any(savePath)
            pop_saveset(EEG_innerEnv, 'filename', [EEG.filename(1:end-4) '_selectICsByCluster'], 'filepath', savePath);
            continue
        end
    
    % Calculate the outermost envelope.
    allIcSubjIdx = find(allIcList(:,1)==uniqueSubj(n,1));
    if isfield(STUDY.selectICsByCluster, 'excludeIcList')
        excludeIcSubjIdx = find(excludeIcList(:,1)==uniqueSubj(n,1));
        if any(excludeIcSubjIdx)
            icToKeepOuterEnv = setdiff(allIcList(allIcSubjIdx,2), excludeIcList(excludeIcSubjIdx,2));
        else
            icToKeepOuterEnv = allIcList(allIcSubjIdx,2);
        end
    else
        icToKeepOuterEnv = allIcList(allIcSubjIdx,2);
    end
    EEG_outermostEnv = pop_subcomp(EEG, setdiff([1:size(EEG.icaweights,1)], icToKeepOuterEnv), 0);
    EEG_outermostEnv = pop_select(EEG_outermostEnv,'channel',selectICsByClusterChan);
    EEG_outermostEnv.icaact = [];

    switch sum(withinSubjectConditionPresent)
        
        % Store ERP of selected clusters for all the common channels across subjects.
        case 0 % No within-subject condition present.
            EEG_innerEnv = pop_select(EEG_innerEnv,'channel',selectICsByClusterChan);
            STUDY.selectICsByCluster.selectICsByClusterErp(:,:,n)                = single(mean(EEG_innerEnv.data,3));
            STUDY.selectICsByCluster.icaact(1:size(EEG_innerEnv.icawinv,2) ,:,n) = single(mean(EEG_innerEnv.icaact,3));
            
            % Compute pvaf.
            STUDY.selectICsByCluster.outermostEnv(:,:,n)          = single([max(mean(EEG_outermostEnv.data,3),[],1); min(mean(EEG_outermostEnv.data,3),[],1)]);
            STUDY.selectICsByCluster.selectICsByClusterEnv(:,:,n) = single([max(mean(EEG_innerEnv.data,3),[],1); min(mean(EEG_innerEnv.data,3),[],1)]);
            STUDY.selectICsByCluster.erpPvaf(:,n)                 = single(100-100*var(mean(EEG_outermostEnv.data,3)-mean(EEG_innerEnv.data,3),0,1)./var(mean(EEG_outermostEnv.data,3),0,1));

        case 1  % One within-subject condition.
            EEG_outermostEnv_original = EEG_outermostEnv;
            for conditionIdx = 1:length(conditionLabelsCell);
                currentConditionLabel = conditionLabelsCell(1,conditionIdx);
                
                % If multiple conditions are combined by STUDY.design.
                if iscell(currentConditionLabel{1,1})
                    EEG_outermostEnv = pop_selectevent(EEG_outermostEnv_original, withinSubjectConditionLabel, currentConditionLabel{1,1},'deleteevents','off','deleteepochs','on','invertepochs','off');
                    EEG_outermostEnv.icaact = [];
                    EEG_innerEnv = pop_subcomp(EEG, setdiff([1:size(EEG.icaweights,1)], icToKeepInnerEnv), 0);
                    EEG_innerEnv = pop_select(EEG_innerEnv,'channel',selectICsByClusterChan);
                    EEG_innerEnv = pop_selectevent(EEG_innerEnv, withinSubjectConditionLabel, currentConditionLabel{1,1},'deleteevents','off','deleteepochs','on','invertepochs','off');
                    
                % If single condition.
                else
                    EEG_outermostEnv = pop_selectevent(EEG_outermostEnv_original, withinSubjectConditionLabel, currentConditionLabel,'deleteevents','off','deleteepochs','on','invertepochs','off');
                    EEG_outermostEnv.icaact = [];
                    EEG_innerEnv = pop_subcomp(EEG, setdiff([1:size(EEG.icaweights,1)], icToKeepInnerEnv), 0);
                    EEG_innerEnv = pop_select(EEG_innerEnv,'channel',selectICsByClusterChan);
                    EEG_innerEnv = pop_selectevent(EEG_innerEnv, withinSubjectConditionLabel, currentConditionLabel,'deleteevents','off','deleteepochs','on','invertepochs','off');
                end
                
                % Store selectICsByClusterected ERP for all the channels common across all subjects
                STUDY.selectICsByCluster.selectICsByClusterErp(:,:,n,conditionIdx)               = single(mean(EEG_innerEnv.data, 3));
                STUDY.selectICsByCluster.icaact(1:size(EEG_innerEnv.icawinv,2),:,n,conditionIdx) = single(mean(EEG_innerEnv.icaact,3));

                % Compute pvaf.
                STUDY.selectICsByCluster.outermostEnv(:,:,n,conditionIdx)          = single([max(mean(EEG_outermostEnv.data,3),[],1); min(mean(EEG_outermostEnv.data,3),[],1)]);
                STUDY.selectICsByCluster.selectICsByClusterEnv(:,:,n,conditionIdx) = single([max(mean(EEG_innerEnv.data,3),[],1); min(mean(EEG_innerEnv.data,3),[],1)]);
                STUDY.selectICsByCluster.erpPvaf(:,n,conditionIdx)                 = single(100-100*var(mean(EEG_outermostEnv.data,3)-mean(EEG_innerEnv.data,3),0,1)./var(mean(EEG_outermostEnv.data,3),0,1));
            end
        case 2
            error('Two within-subject conditions not supported.')
    end
end

close(waitBarHandle)
if any(savePath)
    disp('Cluster-backprojection done.')
    return
else
    assignin('base', 'STUDY', STUDY)
    disp('Data are stored at STUDY.selectICsByCluster.')
end