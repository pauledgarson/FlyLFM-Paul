
% % opens window to select and load multiple datasets
% [file,path]=uigetfile('*.mat','Select TSROImeanPeaks mat-file with 12 regions','MultiSelect','on','/home/paul/Desktop');
% data=strcat(path,file)
% 
% for j=1:size(data,2)
% load(data{j})
% end

regionslist={'OL';'CX';'LX';'LH';'PENP';'INP';'VMNP';'MB';'AL';'SNP';'VLNP';'GNG'};

%making new arrays containing all the data
StimPeaks=cat(3,StimPeaks99,StimPeaks100,StimPeaks101,StimPeaks102,StimPeaks116,StimPeaks117,StimPeaks118,StimPeaks119);
StimResponses=cat(4,StimResponses99,StimResponses100,StimResponses101,StimResponses102,StimResponses116,StimResponses117,StimResponses118,StimResponses119);

%calculating mean for each trial between animals
AvgPeaksFirstTrial=mean(StimPeaks(:,:,[1,5]),3);
AvgPeaksSecTrial=mean(StimPeaks(:,:,[2,6]),3);
AvgPeaksThirdTrial=mean(StimPeaks(:,:,[3,7]),3);
AvgPeaksFourTrial=mean(StimPeaks(:,:,[4,8]),3);

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
    ylim([0, 0.1]);
end

sgtitle('Peak Response to Taste (Trial by Trial)');

subplot(3,2,1);
title('Suc ON');

subplot(3,2,2);
title('Suc OFF');
ylim([0, 0.02]);

subplot(3,2,3);
title('Wat ON');

subplot(3,2,4);
title('Wat OFF');
ylim([0, 0.02]);

subplot(3,2,5);
title('Qui ON');

subplot(3,2,6);
title('Qui OFF');
ylim([0, 0.02]);
