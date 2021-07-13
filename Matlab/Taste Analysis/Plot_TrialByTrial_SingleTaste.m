
% % opens window to select and load multiple datasets
% [file,path]=uigetfile('*.mat','Select TSROImeanPeaks mat-file with 12 regions','MultiSelect','on','/home/paul/Desktop');
% data=strcat(path,file)
% 
% for j=1:size(data,2)
% load(data{j})
% end

regionslist={'OL';'CX';'LX';'LH';'PENP';'INP';'VMNP';'MB';'AL';'SNP';'VLNP';'GNG'};

%making new arrays containing all the data
StimPeaksSuc=cat(3,StimPeaks166,StimPeaks171);
StimResponsesSuc=cat(4,StimResponses171);

StimPeaksWat=cat(3,StimPeaks167,StimPeaks170);
StimResponsesWat=cat(4,StimResponses167,StimResponses170);

StimPeaksQui=cat(3,StimPeaks168,StimPeaks169);
StimResponsesQui=cat(4,StimResponses168,StimResponses169);

%calculating mean for each trial between animals
AvgPeaksSuc=mean(StimPeaksSuc,3);
AvgPeaksWat=mean(StimPeaksWat,3);
AvgPeaksQui=mean(StimPeaksQui,3);

AvgPeaksON=cat(3, AvgPeaksSuc([1 3 5],:),AvgPeaksWat([1 3 5],:),AvgPeaksQui([1 3 5],:));
AvgPeaksOFF=cat(3, AvgPeaksSuc([2 4 6],:),AvgPeaksWat([2 4 6],:),AvgPeaksQui([2 4 6],:));
AvgPeaksAll=cat(3,AvgPeaksON, AvgPeaksOFF);


% f1=figure;
% 
% for i=1:6
%     subplot(2,3,i);
%     bar(reshape(AvgPeaksAll(:,:,i),[12 3]),'FaceColor','flat');
%     xticklabels(regionslist);
%     ylabel('Mean dF/F');
%     legend({'First' 'Second' 'Third'},'Orientation','horizontal','Location','bestoutside');
%     ylim([0, 0.12]);
% end
% 
% sgtitle('Peak Response to Taste (Trial by Trial)');
% 
% subplot(2,3,1);
% title('Suc ON');
% subplot(2,3,2);
% title('Wat ON');
% subplot(2,3,3);
% title('Qui ON');
% subplot(2,3,4);
% title('Suc OFF');
% ylim([0, 0.02]);
% subplot(2,3,5);
% title('Wat OFF');
% ylim([0, 0.02]);
% subplot(2,3,6);
% title('Qui OFF');
% ylim([0, 0.02]);


AvgResponseSuc=mean(StimResponsesSuc,4);
AvgResponseWat=mean(StimResponsesWat,4);
AvgResponseQui=mean(StimResponsesQui,4);

AvgResponseON=cat(3, AvgResponseSuc(:,:,[1 3 5]), AvgResponseWat(:,:,[1 3 5]), AvgResponseQui(:,:,[1 3 5]));
AvgResponseOFF=cat(3, AvgResponseSuc(:,:,[2 4 6]), AvgResponseWat(:,:,[2 4 6]), AvgResponseQui(:,:,[2 4 6]));

% normalizing traces to mean fluorescence before stimulus onset 
avgBeforeON=mean(AvgResponseON(1:19,:,:),1);
avgNormBeforeON=AvgResponseON-avgBeforeON;

avgBeforeOFF=mean(AvgResponseOFF(1:19,:,:),1);
avgNormBeforeOFF=AvgResponseOFF-avgBeforeOFF;


f2=figure;

for i=1:9
    subplot(3,3,i);
    plot(avgNormBeforeON(:,:,i),'LineWidth',1.5); 
    xline(20,'linestyle','--'); 
    ylabel('Mean dF/F'); 
    ylim([-0.02 0.05]);
end

legend(regionslist,'Location','bestoutside');
sgtitle('ON-Response to Taste (Trial by Trial)');
colororder(jet(12));

subplot(3,3,1);
title('Suc First');
subplot(3,3,2);
title('Suc Second');
subplot(3,3,3);
title('Suc Third');
subplot(3,3,4);
title('Wat First');
subplot(3,3,5);
title('Wat Second');
subplot(3,3,6);
title('Wat Third');
subplot(3,3,7);
title('Qui First');
subplot(3,3,8);
title('Qui Second');
subplot(3,3,9);
title('Qui Third');


f3=figure;

for i=1:9
    subplot(3,3,i);
    plot(avgNormBeforeOFF(:,:,i),'LineWidth',1.5); 
    xline(20,'linestyle','--'); 
    ylabel('Mean dF/F'); 
    ylim([-0.02 0.05]);
end

legend(regionslist,'Location','bestoutside');
sgtitle('OFF-Response to Taste (Trial by Trial)');
colororder(jet(12));

subplot(3,3,1);
title('Suc First');
subplot(3,3,2);
title('Suc Second');
subplot(3,3,3);
title('Suc Third');
subplot(3,3,4);
title('Wat First');
subplot(3,3,5);
title('Wat Second');
subplot(3,3,6);
title('Wat Third');
subplot(3,3,7);
title('Qui First');
subplot(3,3,8);
title('Qui Second');
subplot(3,3,9);
title('Qui Third');
