
%% Calculating and plotting the Mean Peak response over different trials

% %opens window to select and load multiple datasets
% [file,path]=uigetfile('*.mat','Select TSROImeanPeaks mat-file with 12 regions','MultiSelect','on','/home/paul/Desktop');
% data=strcat(path,file)
% 
% for j=1:size(data,2)
% load(data{j})
% end

%making new arrays containing all the data
StimPeaks=cat(3,StimPeaks76,StimPeaks77,StimPeaks79);
StimResponses=cat(4,StimResponses76,StimResponses77,StimResponses79);

%calculating the mean Peak Response (and correcting for water response)
AvgPeaks=mean(StimPeaks,3);
% % StdevPeaks=std(StimPeaks,0,3);
% AvgPeaksCor=[AvgPeaks(1,:)-AvgPeaks(3,:);AvgPeaks(2,:)-AvgPeaks(4,:);AvgPeaks(5,:)-AvgPeaks(3,:);AvgPeaks(6,:)-AvgPeaks(4,:)];

AvgResponse=mean(StimResponses,4);
% AvgResponseCor=cat(3,[AvgResponse(:,:,1)-AvgResponse(:,:,3)],[AvgResponse(:,:,2)-AvgResponse(:,:,4)],[AvgResponse(:,:,5)-AvgResponse(:,:,3)],[AvgResponse(:,:,6)-AvgResponse(:,:,4)]);

%plotting Peaks as bar chart
f1=figure;
b=bar(AvgPeaks,'FaceColor','flat');
regionslist={'OL';'CX';'LX';'LH';'PENP';'INP';'VMNP';'MB';'AL';'SNP';'VLNP';'GNG'};

legend(regionslist,'Orientation','horizontal','Location','bestoutside');
xticklabels({'Suc ON','Suc OFF','Qui ON','Qui OFF'});

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
title('Peak Response to Taste');

% %plotting Peaks corrected for water response
% f2=figure;
% b=bar(AvgPeaksCor,'FaceColor','flat');
% 
% legend(regionslist,'Orientation','horizontal','Location','bestoutside');
% xticklabels({'Suc ON','Suc OFF','Qui ON','Qui OFF'});

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
title('Peak Response to Taste');


% normalizing traces to mean fluorescence before stimulus onset 
avgBefore=mean(StimResponses(1:19,:,:,:),1);
avgNormBefore=StimResponses-avgBefore;
AvgavgNormBefore=mean(avgNormBefore,4);

f3=figure;


for i=1:4
    subplot(2,2,i);
    plot(AvgavgNormBefore(:,:,i),'LineWidth',1.5); 
    xline(20,'linestyle','--'); 
    ylabel('Mean dF/F'); 
    ylim([-0.03,0.07]);
    yticks([-0.02:0.02:0.06]);
end

legend(regionslist,'Location','best');
sgtitle('Response to Taste');
colororder(jet(12));


subplot(2,2,1);
title('Suc ON');
subplot(2,2,2);
title('Suc OFF');

subplot(2,2,3);
title('Qui ON');
subplot(2,2,4);
title('Qui OFF');

