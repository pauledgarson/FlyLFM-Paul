
% % opens window to select and load multiple datasets
% [file,path]=uigetfile('*.mat','Select TSROImeanPeaks mat-file with 12 regions','MultiSelect','on','/home/paul/Desktop');
% data=strcat(path,file)
% 
% for j=1:size(data,2)
% load(data{j})
% end

regionslist={'OL';'CX';'LX';'LH';'PENP';'INP';'VMNP';'MB';'AL';'SNP';'VLNP';'GNG'};

%making new arrays containing all the data

StimResponses_Starved=cat(4,StimResponses134,StimResponses135,StimResponses136,StimResponses137,StimResponses142,StimResponses143,StimResponses144,StimResponses145,StimResponses154,StimResponses155,StimResponses156,StimResponses157);

OnSucSta=reshape(StimResponses_Starved(:,:,1,:),[30,12,12]);
OffSucSta=reshape(StimResponses_Starved(:,:,2,:),[30,12,12]);
OnWatSta=reshape(StimResponses_Starved(:,:,3,:),[30,12,12]);
OffWatSta=reshape(StimResponses_Starved(:,:,4,:),[30,12,12]);
OnQuiSta=reshape(StimResponses_Starved(:,:,5,:),[30,12,12]);
OffQuiSta=reshape(StimResponses_Starved(:,:,6,:),[30,12,12]);

PeakONsucSta=max(OnSucSta,[],1)-mean(OnSucSta([1:9],:,:));
PeakOFFsucSta=max(OffSucSta,[],1)-mean(OffSucSta([1:9],:,:));

PeakONwatSta=max(OnWatSta,[],1)-mean(OnWatSta([1:9],:,:));
PeakOFFwatSta=max(OffWatSta,[],1)-mean(OffWatSta([1:9],:,:));

PeakONquiSta=max(OnQuiSta,[],1)-mean(OnQuiSta([1:9],:,:));
PeakOFFquiSta=max(OffQuiSta,[],1)-mean(OffQuiSta([1:9],:,:));

StimPeaks_Starved=cat(1,PeakONsucSta,PeakOFFsucSta,PeakONwatSta,PeakOFFwatSta,PeakONquiSta,PeakOFFquiSta);

%calculating mean for each trial between animals
AvgPeaksFirstTrial=mean(StimPeaks_Starved(:,:,[1,5,9]),3);
AvgPeaksSecTrial=mean(StimPeaks_Starved(:,:,[2,6,10]),3);
AvgPeaksThirdTrial=mean(StimPeaks_Starved(:,:,[3,7,11]),3);
AvgPeaksFourTrial=mean(StimPeaks_Starved(:,:,[4,8,12]),3);

AvgPeaksAllTrials=cat(3, AvgPeaksFirstTrial,AvgPeaksSecTrial,AvgPeaksThirdTrial,AvgPeaksFourTrial);


% %plotting Peaks for SUC_ON as bar chart
% f1=figure;
% b=bar(reshape(AvgPeaksAllTrials(1,:,:),[12 4]),'FaceColor','flat');
% legend({'First' 'Second' 'Third' 'Fourth'},'fontsize',12,'Orientation','horizontal','Location','bestoutside');
% xticklabels(regionslist);
% ylabel('Mean dF/F','fontsize',14);
% title('Peak ON-Response to Sucrose Over Trials');
% 
% %plotting Peaks for SUC_OFF as bar chart
% f2=figure;
% b=bar(reshape(AvgPeaksAllTrials(2,:,:),[12 4]),'FaceColor','flat');
% legend({'First' 'Second' 'Third' 'Fourth'},'fontsize',12,'Orientation','horizontal','Location','bestoutside');
% xticklabels(regionslist);
% ylabel('Mean dF/F','fontsize',14);
% title('Peak OFF-Response to Sucrose Over Trials');
% 
% %plotting Peaks for WAT_ON as bar chart
% f3=figure;
% b=bar(reshape(AvgPeaksAllTrials(3,:,:),[12 4]),'FaceColor','flat');
% legend({'First' 'Second' 'Third' 'Fourth'},'fontsize',12,'Orientation','horizontal','Location','bestoutside');
% xticklabels(regionslist);
% ylabel('Mean dF/F','fontsize',14);
% title('Peak ON-Response to Water Over Trials');

f1=figure;

for i=1:6
    subplot(3,2,i);
    bar(reshape(AvgPeaksAllTrials(i,:,:),[12 4]),'FaceColor','flat');
    xticklabels(regionslist);
    ylabel('Mean dF/F','fontsize',14);
    legend({'First' 'Second' 'Third' 'Fourth'},'fontsize',12,'Orientation','horizontal','Location','bestoutside');
    ylim([0, 0.15]);
end

sgtitle('Peak Response to Taste Starved (Trial by Trial)');

subplot(3,2,1);
title('Suc ON');

subplot(3,2,2);
title('Suc OFF');
ylim([0, 0.04]);

subplot(3,2,3);
title('Wat ON');

subplot(3,2,4);
title('Wat OFF');
ylim([0, 0.04]);

subplot(3,2,5);
title('Qui ON');

subplot(3,2,6);
title('Qui OFF');
ylim([0, 0.04]);
