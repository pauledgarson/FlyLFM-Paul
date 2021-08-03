%% Calculating and plotting the Mean Peak response over different trials

% opens window to select and load multiple datasets
[file,path]=uigetfile('*.mat','Select TSROImeanPeaks mat-file with 12 regions','MultiSelect','on','/home/paul/Desktop');
data=strcat(path,file)

for j=1:size(data,2)
load(data{j})
end

ResponsesSucFed=cat(4,StimResponses184,StimResponses195,StimResponses196,StimResponses205,StimResponses210,StimResponses213);
ResponsesWatFed=cat(4,StimResponses185,StimResponses194,StimResponses197,StimResponses206,StimResponses209,StimResponses212);
ResponsesQuiFed=cat(4,StimResponses186,StimResponses193,StimResponses198,StimResponses207,StimResponses208,StimResponses211);

% averaging over trials first
RespSucON=squeeze(mean(cat(3,ResponsesSucFed(:,:,1,:),ResponsesSucFed(:,:,3,:),ResponsesSucFed(:,:,5,:)),3));
RespSucOFF=squeeze(mean(cat(3,ResponsesSucFed(:,:,2,:),ResponsesSucFed(:,:,4,:),ResponsesSucFed(:,:,6,:)),3));

RespWatON=squeeze(mean(cat(3,ResponsesWatFed(:,:,1,:),ResponsesWatFed(:,:,3,:),ResponsesWatFed(:,:,5,:)),3));
RespWatOFF=squeeze(mean(cat(3,ResponsesWatFed(:,:,2,:),ResponsesWatFed(:,:,4,:),ResponsesWatFed(:,:,6,:)),3));

RespQuiON=squeeze(mean(cat(3,ResponsesQuiFed(:,:,1,:),ResponsesQuiFed(:,:,3,:),ResponsesQuiFed(:,:,5,:)),3));
RespQuiOFF=squeeze(mean(cat(3,ResponsesQuiFed(:,:,2,:),ResponsesQuiFed(:,:,4,:),ResponsesQuiFed(:,:,6,:)),3));

Response=cat(4,RespSucON,RespSucOFF,RespWatON,RespWatOFF,RespQuiON,RespQuiOFF);

% calculating average response over animals
AvgResponse=mean(Response,4);

% calculating taste peaks for each animal (-> regions x taste x animals)
Peaks=squeeze(max(Response([1:30],:,:,:),[],1)-mean(Response([1:15],:,:,:),1));
% Peaks=squeeze(max(Response([1:40],:,:,:),[],1));

%calculating mean and std over animals
AvgPeaks=mean(Peaks,3);
StdPeaks=std(Peaks,0,3);

regionslist={'OL';'CX';'LX';'LH';'PENP';'INP';'VMNP';'MB';'AL';'SNP';'VLNP';'GNG'};

%plotting Peaks as bar chart
f1=figure;
b=bar(AvgPeaks','FaceColor','flat');
legend(regionslist,'Orientation','horizontal','Location','bestoutside');
xticklabels({'Suc ON','Suc OFF','Wat ON','Wat OFF','Qui ON','Qui OFF'});
ylim([0 0.04]);

for k = 1:12
    b(k).CData = k;
end
colormap 'jet'

ylabel('Mean dF/F','fontsize',14);
title('Peak Response to Taste (Fed)');


% Plotting traces of average responses across animals
f3=figure;

for i=1:6
    subplot(3,2,i);
    plot(AvgResponse(:,:,i),'LineWidth',1.5); 
    xline(20,'linestyle','--'); 
    ylabel('Mean dF/F'); 
    ylim([-0.01 0.04]);
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
