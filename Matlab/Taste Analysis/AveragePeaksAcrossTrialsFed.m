
%% Calculating and plotting the Mean Peak response over different trials

% opens window to select and load multiple datasets
[file,path]=uigetfile('*.mat','Select TSROImeanPeaks mat-file with 12 regions','MultiSelect','on','/home/paul/Desktop');
data=strcat(path,file)

for j=1:size(data,2)
load(data{j})
end

% % making new arrays containing all the data
% PeaksSucFed=cat(3,StimPeaks184,StimPeaks195,StimPeaks196,StimPeaks205,StimPeaks210,StimPeaks213);
% PeaksWatFed=cat(3,StimPeaks185,StimPeaks194,StimPeaks197,StimPeaks206,StimPeaks209,StimPeaks212);
% PeaksQuiFed=cat(3,StimPeaks186,StimPeaks193,StimPeaks198,StimPeaks207,StimPeaks208,StimPeaks211);

ResponsesSucFed=cat(4,StimResponses184,StimResponses195,StimResponses196,StimResponses205,StimResponses210,StimResponses213);
ResponsesWatFed=cat(4,StimResponses185,StimResponses194,StimResponses197,StimResponses206,StimResponses209,StimResponses212);
ResponsesQuiFed=cat(4,StimResponses186,StimResponses193,StimResponses198,StimResponses207,StimResponses208,StimResponses211);

%calculating the mean Peaks over animals and then over trials
AvgPeaksSuc=mean(PeaksSucFed,3);
AvgPeaksWat=mean(PeaksWatFed,3);
AvgPeaksQui=mean(PeaksQuiFed,3);

AvgPeaksSucON=mean([AvgPeaksSuc(1,:);AvgPeaksSuc(3,:);AvgPeaksSuc(5,:)]);
AvgPeaksSucOFF=mean([AvgPeaksSuc(2,:);AvgPeaksSuc(4,:);AvgPeaksSuc(6,:)]);

AvgPeaksWatON=mean([AvgPeaksWat(1,:);AvgPeaksWat(3,:);AvgPeaksWat(5,:)]);
AvgPeaksWatOFF=mean([AvgPeaksWat(2,:);AvgPeaksWat(4,:);AvgPeaksWat(6,:)]);

AvgPeaksQuiON=mean([AvgPeaksQui(1,:);AvgPeaksQui(3,:);AvgPeaksQui(5,:)]);
AvgPeaksQuiOFF=mean([AvgPeaksQui(2,:);AvgPeaksQui(4,:);AvgPeaksQui(6,:)]);

AvgPeaks=[AvgPeaksSucON;AvgPeaksSucOFF;AvgPeaksWatON;AvgPeaksWatOFF;AvgPeaksQuiON;AvgPeaksQuiOFF];

%calculating the mean Response over animals and then over trials
AvgRespSuc=mean(ResponsesSucFed,4);
AvgRespWat=mean(ResponsesWatFed,4);
AvgRespQui=mean(ResponsesQuiFed,4);

AvgRespSucON=mean(cat(3,AvgRespSuc(:,:,1),AvgRespSuc(:,:,3),AvgRespSuc(:,:,5)),3);
AvgRespSucOFF=mean(cat(3,AvgRespSuc(:,:,2),AvgRespSuc(:,:,4),AvgRespSuc(:,:,6)),3);

AvgRespWatON=mean(cat(3,AvgRespWat(:,:,1),AvgRespWat(:,:,3),AvgRespWat(:,:,5)),3);
AvgRespWatOFF=mean(cat(3,AvgRespWat(:,:,2),AvgRespWat(:,:,4),AvgRespWat(:,:,6)),3);

AvgRespQuiON=mean(cat(3,AvgRespQui(:,:,1),AvgRespQui(:,:,3),AvgRespQui(:,:,5)),3);
AvgRespQuiOFF=mean(cat(3,AvgRespQui(:,:,2),AvgRespQui(:,:,4),AvgRespQui(:,:,6)),3);

AvgResponse=cat(3,AvgRespSucON,AvgRespSucOFF,AvgRespWatON,AvgRespWatOFF,AvgRespQuiON,AvgRespQuiOFF);

% recalculating peaks
AvgPeaks2=max(AvgResponse([1:30],:,:),[],1)-mean(AvgResponse([1:15],:,:),1)
AvgPeaks2=reshape(AvgPeaks2,[12,6]);

regionslist={'OL';'CX';'LX';'LH';'PENP';'INP';'VMNP';'MB';'AL';'SNP';'VLNP';'GNG'};

%plotting Peaks as bar chart
f1=figure;
b=bar(AvgPeaks2','FaceColor','flat');
legend(regionslist,'Orientation','horizontal','Location','bestoutside');
xticklabels({'Suc ON','Suc OFF','Wat ON','Wat OFF','Qui ON','Qui OFF'});

for k = 1:12
    b(k).CData = k;
end
colormap 'jet'

ylabel('Mean dF/F','fontsize',14);
title('Peak Response to Taste (Fed)');

% %plotting Peaks corrected for water response
% f2=figure;
% b=bar(AvgPeaksCor,'FaceColor','flat');
% 
% legend(regionslist,'Orientation','horizontal','Location','bestoutside');
% xticklabels({'Suc ON','Suc OFF','Qui ON','Qui OFF'});
% 
% for k = 1:12
%     b(k).CData = k;
% end
% colormap 'jet'
% 
% ylabel('Mean dF/F','fontsize',14);
% title('Peak Response to Taste');

% normalizing traces to mean fluorescence before stimulus onset 
avgBefore=mean(AvgResponse(1:9,:,:),1);
avgNormBefore=AvgResponse-avgBefore;

f3=figure;

for i=1:6
    subplot(3,2,i);
    plot(AvgResponse(:,:,i),'LineWidth',1.5); 
    xline(20,'linestyle','--'); 
    ylabel('Mean dF/F'); 
    ylim([-0.03 0.03]);
end

legend(regionslist,'Location','best');
sgtitle('Response to Taste (Fed)');
colororder(jet(12));

subplot(3,2,1);
title('Suc ON');
subplot(3,2,2);
title('Suc OFF');
ylim([-0.01 0.04]);
subplot(3,2,3);
title('Wat ON');
subplot(3,2,4);
title('Wat OFF');
ylim([-0.01 0.04]);
subplot(3,2,5);
title('Qui ON');
subplot(3,2,6);
title('Qui OFF');
ylim([-0.01 0.04]);
