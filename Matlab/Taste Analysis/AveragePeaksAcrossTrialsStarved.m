
%% Calculating and plotting the Mean Peak response over different trials

% opens window to select and load multiple datasets
[file,path]=uigetfile('*.mat','Select TSROImeanPeaks mat-file with 12 regions','MultiSelect','on','/home/paul/Desktop');
data=strcat(path,file)

for j=1:size(data,2)
load(data{j})
end

ResponsesSucSta=cat(4,StimResponses214,StimResponses219,StimResponses225,StimResponses232,StimResponses237,StimResponses239);
ResponsesWatSta=cat(4,StimResponses215,StimResponses218,StimResponses224,StimResponses233,StimResponses236,StimResponses240);
ResponsesQuiSta=cat(4,StimResponses216,StimResponses217,StimResponses223,StimResponses234,StimResponses235,StimResponses241);


%calculating the mean Response over animals and then over trials
AvgRespSuc=mean(ResponsesSucSta,4);
AvgRespWat=mean(ResponsesWatSta,4);
AvgRespQui=mean(ResponsesQuiSta,4);

AvgRespSucON=mean(cat(3,AvgRespSuc(:,:,1),AvgRespSuc(:,:,3),AvgRespSuc(:,:,5)),3);
AvgRespSucOFF=mean(cat(3,AvgRespSuc(:,:,2),AvgRespSuc(:,:,4),AvgRespSuc(:,:,6)),3);

AvgRespWatON=mean(cat(3,AvgRespWat(:,:,1),AvgRespWat(:,:,3),AvgRespWat(:,:,5)),3);
AvgRespWatOFF=mean(cat(3,AvgRespWat(:,:,2),AvgRespWat(:,:,4),AvgRespWat(:,:,6)),3);

AvgRespQuiON=mean(cat(3,AvgRespQui(:,:,1),AvgRespQui(:,:,3),AvgRespQui(:,:,5)),3);
AvgRespQuiOFF=mean(cat(3,AvgRespQui(:,:,2),AvgRespQui(:,:,4),AvgRespQui(:,:,6)),3);

AvgResponse=cat(3,AvgRespSucON,AvgRespSucOFF,AvgRespWatON,AvgRespWatOFF,AvgRespQuiON,AvgRespQuiOFF);

% recalculating peaks
AvgPeaks2=squeeze(max(AvgResponse([1:30],:,:),[],1)-mean(AvgResponse([1:15],:,:),1));


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
title('Peak Response to Taste (Starved)');

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
sgtitle('Response to Taste (Starved)');
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
