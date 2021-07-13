
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

%calculating the mean Peak Response (and correcting for water response)
AvgPeaks=mean(StimPeaks_Fed(:,:,[5,9]),3);
% StdevPeaks=std(StimPeaks,0,3);
AvgPeaksCor=[AvgPeaks(1,:)-AvgPeaks(3,:);AvgPeaks(2,:)-AvgPeaks(4,:);AvgPeaks(5,:)-AvgPeaks(3,:);AvgPeaks(6,:)-AvgPeaks(4,:)];

AvgResponse=mean(StimResponses_Fed(:,:,:,[5,9]),4);
AvgResponseCor=cat(3,[AvgResponse(:,:,1)-AvgResponse(:,:,3)],[AvgResponse(:,:,2)-AvgResponse(:,:,4)],[AvgResponse(:,:,5)-AvgResponse(:,:,3)],[AvgResponse(:,:,6)-AvgResponse(:,:,4)]);

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
title('Peak Response to Taste 1st Trial (Fed)');
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
avgBefore=mean(StimResponses_Fed(1:9,:,:,:),1);
avgNormBefore=StimResponses_Fed-avgBefore;
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
sgtitle('Response to Taste 1st Trial (Fed)');
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

