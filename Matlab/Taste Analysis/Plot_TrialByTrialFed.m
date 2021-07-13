
% % opens window to select and load multiple datasets
% [file,path]=uigetfile('*.mat','Select TSROImeanPeaks mat-file with 12 regions','MultiSelect','on','/home/paul/Desktop');
% data=strcat(path,file)
% 
% for j=1:size(data,2)
% load(data{j})
% end

regionslist={'OL';'CX';'LX';'LH';'PENP';'INP';'VMNP';'MB';'AL';'SNP';'VLNP';'GNG'};

%making new arrays containing all the data
StimResponses_Fed=cat(4,StimResponses146,StimResponses147,StimResponses148,StimResponses149,StimResponses150,StimResponses151,StimResponses152,StimResponses153,StimResponses160,StimResponses161,StimResponses162,StimResponses163);

OnSucFed=reshape(StimResponses_Fed(:,:,1,:),[30,12,12]);
OffSucFed=reshape(StimResponses_Fed(:,:,2,:),[30,12,12]);
OnWatFed=reshape(StimResponses_Fed(:,:,3,:),[30,12,12]);
OffWatFed=reshape(StimResponses_Fed(:,:,4,:),[30,12,12]);
OnQuiFed=reshape(StimResponses_Fed(:,:,5,:),[30,12,12]);
OffQuiFed=reshape(StimResponses_Fed(:,:,6,:),[30,12,12]);

PeakONsucFed=max(OnSucFed,[],1)-mean(OnSucFed([1:9],:,:));
PeakOFFsucFed=max(OffSucFed,[],1)-mean(OffSucFed([1:9],:,:));

PeakONwatFed=max(OnWatFed,[],1)-mean(OnWatFed([1:9],:,:));
PeakOFFwatFed=max(OffWatFed,[],1)-mean(OffWatFed([1:9],:,:));

PeakONquiFed=max(OnQuiFed,[],1)-mean(OnQuiFed([1:9],:,:));
PeakOFFquiFed=max(OffQuiFed,[],1)-mean(OffQuiFed([1:9],:,:));

StimPeaks_Fed=cat(1,PeakONsucFed,PeakOFFsucFed,PeakONwatFed,PeakOFFwatFed,PeakONquiFed,PeakOFFquiFed);

%calculating mean for each trial between animals
AvgPeaksFirstTrial=mean(StimPeaks_Fed(:,:,[1,5,9]),3);
AvgPeaksSecTrial=mean(StimPeaks_Fed(:,:,[2,6,10]),3);
AvgPeaksThirdTrial=mean(StimPeaks_Fed(:,:,[3,7,11]),3);
AvgPeaksFourTrial=mean(StimPeaks_Fed(:,:,[4,8,12]),3);

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
    ylim([0, 0.12]);
end

sgtitle('Peak Response to Taste Fed (Trial by Trial)');

subplot(3,2,1);
title('Suc ON');

subplot(3,2,2);
title('Suc OFF');
ylim([0, 0.03]);

subplot(3,2,3);
title('Wat ON');

subplot(3,2,4);
title('Wat OFF');
ylim([0, 0.03]);

subplot(3,2,5);
title('Qui ON');

subplot(3,2,6);
title('Qui OFF');
ylim([0, 0.03]);
