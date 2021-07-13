
%% Calculating and plotting the Mean Peak response over different trials/animals for Putrescine Data

% % opens window to select and load multiple datasets
% [file,path]=uigetfile('*.mat','Select TSROILHPeaks mat-file','MultiSelect','on','/home/paul/Desktop');
% data=strcat(path,file)

% for j=1:size(data,2)
% load(data{j})
% end

%making new arrays containing all the data
StimPeaks=cat(3,StimPeaks305,StimPeaks309);
StimResponses=cat(4,StimResponses305,StimResponses309);

%calculating the mean Peak Response 
AvgPeaks=mean(StimPeaks,3);
% StdevPeaks=std(StimPeaks,0,3);

AvgResponse=mean(StimResponses,4);


%plotting Peaks as bar chart
f1=figure;
b=bar(AvgPeaks,'FaceColor','flat');
regionslist={'AL','AM','PM'};

legend(regionslist,'Orientation','horizontal','Location','bestoutside');
xticklabels({'First','Second','Third','Fourth'});


ylabel('Mean dF/F','fontsize',14);
title('Peak Response to Putrescine');


% normalizing traces to mean fluorescence before stimulus onset 
avgBefore=mean(StimResponses(1:50,:,:,:),1);
avgNormBefore=StimResponses-avgBefore;
AvgavgNormBefore=mean(avgNormBefore,4);

f2=figure;

for i=1:4
    subplot(2,2,i);
    plot(AvgavgNormBefore(:,:,i),'LineWidth',1.5); 
    xline(100,'linestyle','--'); 
    ylabel('Mean dF/F');
    ylim([-0.01 0.1]);
end

legend(regionslist,'Location','best');
sgtitle('Response to Putrescine');


subplot(2,2,1);
title('First');
subplot(2,2,2);
title('Second');
subplot(2,2,3);
title('Third');
subplot(2,2,4);
title('Fourth');


