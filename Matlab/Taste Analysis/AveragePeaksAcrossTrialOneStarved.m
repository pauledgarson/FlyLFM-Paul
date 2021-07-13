
%% Calculating and plotting the Mean Peak response over different trials
% 
% % opens window to select and load multiple datasets
% [file,path]=uigetfile('*.mat','Select TSROImeanPeaks mat-file with 12 regions','MultiSelect','on','/home/paul/Desktop');
% data=strcat(path,file)
% 
% for j=1:size(data,2)
% load(data{j})
% end

%making new arrays containing all the data
% StimPeaks=cat(3,StimPeaks99,StimPeaks100,StimPeaks101,StimPeaks102,StimPeaks116,StimPeaks117,StimPeaks118,StimPeaks119);
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
%calculating the mean Peak Response (and correcting for water response)
AvgPeaks=mean(StimPeaks_Starved(:,:,[1,9]),3);
% StdevPeaks=std(StimPeaks,0,3);
AvgPeaksCor=[AvgPeaks(1,:)-AvgPeaks(3,:);AvgPeaks(2,:)-AvgPeaks(4,:);AvgPeaks(5,:)-AvgPeaks(3,:);AvgPeaks(6,:)-AvgPeaks(4,:)];

AvgResponse=mean(StimResponses_Starved(:,:,[1,9]),4);
% AvgResponseCor=cat(3,[AvgResponse(:,:,1)-AvgResponse(:,:,3)],[AvgResponse(:,:,2)-AvgResponse(:,:,4)],[AvgResponse(:,:,5)-AvgResponse(:,:,3)],[AvgResponse(:,:,6)-AvgResponse(:,:,4)]);

regionslist={'OL';'CX';'LX';'LH';'PENP';'INP';'VMNP';'MB';'AL';'SNP';'VLNP';'GNG'};
%plotting Peaks as bar chart
f1=figure;
b=bar(AvgPeaks,'FaceColor','flat');


legend(regionslist,'Orientation','horizontal','Location','bestoutside');
xticklabels({'Suc ON','Suc OFF','Wat ON','Wat OFF','Qui ON','Qui OFF'});

% hold on
% x = [];
% for i = 1:12
%     x = [x ; b(i).XEndPoints];
% end
% 
% errorbar(x', StdevPeaks);
% hold off

for k = 1:12
    b(k).CData = k;
end
colormap 'jet'

ylabel('Mean dF/F','fontsize',14);
title('Peak Response to Taste 1st Trial (Starved)');
% 
% %plotting Peaks corrected for water response
% f2=figure;
% b=bar(AvgPeaksCor,'FaceColor','flat');
% 
% legend(regionslist,'Orientation','horizontal','Location','bestoutside');
% xticklabels({'Suc ON','Suc OFF','Qui ON','Qui OFF'});
% 
% % hold on
% % x = [];
% % for i = 1:12
% %     x = [x ; b(i).XEndPoints];
% % end
% % 
% % errorbar(x', StdevPeaks);
% % hold off
% 
% for k = 1:12
%     b(k).CData = k;
% end
% colormap 'jet'
% 
% ylabel('Mean dF/F','fontsize',14);
% title('Peak Response to Taste');

% normalizing traces to mean fluorescence before stimulus onset 
avgBefore=mean(StimResponses_Starved(1:9,:,:,:),1);
avgNormBefore=StimResponses_Starved-avgBefore;
AvgavgNormBefore=mean(avgNormBefore,4);

f3=figure;


for i=1:6
    subplot(3,2,i);
    plot(AvgavgNormBefore(:,:,i),'LineWidth',1.5); 
    xline(10,'linestyle','--'); 
    ylabel('Mean dF/F'); 
    ylim([-0.04 0.12]);
end

legend(regionslist,'Location','best');
sgtitle('Response to Taste 1st Trial (Starved)');
colororder(jet(12));

subplot(3,2,1);
title('Suc ON');
subplot(3,2,2);
title('Suc OFF');
subplot(3,2,3);
title('Wat ON');
subplot(3,2,4);
title('Wat OFF');
subplot(3,2,5);
title('Qui ON');
subplot(3,2,6);
title('Qui OFF');

