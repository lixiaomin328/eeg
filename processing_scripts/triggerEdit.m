%eventEdit load EEGdata first
[p2DecisionStart,p2DecisionMade] = triggerFindP2(subId);
for i = 1:length(p2DecisionStart)
    EEG.event(p2DecisionStart(i)+3).type=3;
    EEG.event(p2DecisionMade(i)+3).type=5;
    EEG.urevent(p2DecisionStart(i)+3).type=3;
    EEG.urevent(p2DecisionMade(i)+3).type=5;
end