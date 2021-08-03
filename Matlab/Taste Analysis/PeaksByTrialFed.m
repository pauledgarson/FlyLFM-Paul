%% Calculating and plotting the Mean Peak response between different trials

% opens window to select and load multiple datasets
[file,path]=uigetfile('*.mat','Select TSROImeanPeaks mat-file with 12 regions','MultiSelect','on','/home/paul/Desktop');
data=strcat(path,file)

for j=1:size(data,2)
load(data{j})
end

ResponsesSucFed=cat(4,StimResponses184,StimResponses195,StimResponses196,StimResponses205,StimResponses210,StimResponses213);
ResponsesWatFed=cat(4,StimResponses185,StimResponses194,StimResponses197,StimResponses206,StimResponses209,StimResponses212);
ResponsesQuiFed=cat(4,StimResponses186,StimResponses193,StimResponses198,StimResponses207,StimResponses208,StimResponses211);

%calculating Peaks for every stimulus and animal (region x stimulus x animal)
PeaksSucFed=squeeze(max(ResponsesSucFed([1:30],:,:,:),[],1)-mean(ResponsesSucFed([1:15],:,:,:),1));
PeaksWatFed=squeeze(max(ResponsesWatFed([1:30],:,:,:),[],1)-mean(ResponsesWatFed([1:15],:,:,:),1));
PeaksQuiFed=squeeze(max(ResponsesQuiFed([1:30],:,:,:),[],1)-mean(ResponsesQuiFed([1:15],:,:,:),1));

%saving each peak as one matrix (region x animal)
SucFirstOn=squeeze(PeaksSucFed(:,1,:));
SucFirstOff=squeeze(PeaksSucFed(:,2,:));
SucSecOn=squeeze(PeaksSucFed(:,3,:));
SucSecOff=squeeze(PeaksSucFed(:,4,:));
SucThirdOn=squeeze(PeaksSucFed(:,5,:));
SucThirdOff=squeeze(PeaksSucFed(:,6,:));

WatFirstOn=squeeze(PeaksWatFed(:,1,:));
WatFirstOff=squeeze(PeaksWatFed(:,2,:));
WatSecOn=squeeze(PeaksWatFed(:,3,:));
WatSecOff=squeeze(PeaksWatFed(:,4,:));
WatThirdOn=squeeze(PeaksWatFed(:,5,:));
WatThirdOff=squeeze(PeaksWatFed(:,6,:));

QuiFirstOn=squeeze(PeaksQuiFed(:,1,:));
QuiFirstOff=squeeze(PeaksQuiFed(:,2,:));
QuiSecOn=squeeze(PeaksQuiFed(:,3,:));
QuiSecOff=squeeze(PeaksQuiFed(:,4,:));
QuiThirdOn=squeeze(PeaksQuiFed(:,5,:));
QuiThirdOff=squeeze(PeaksQuiFed(:,6,:));

% % averaging over animals for every trial
% RespSucON=squeeze(mean(cat(3,ResponsesSucFed(:,:,1,:),ResponsesSucFed(:,:,3,:),ResponsesSucFed(:,:,5,:)),4));
% RespSucOFF=squeeze(mean(cat(3,ResponsesSucFed(:,:,2,:),ResponsesSucFed(:,:,4,:),ResponsesSucFed(:,:,6,:)),4));
% 
% RespWatON=squeeze(mean(cat(3,ResponsesWatFed(:,:,1,:),ResponsesWatFed(:,:,3,:),ResponsesWatFed(:,:,5,:)),4));
% RespWatOFF=squeeze(mean(cat(3,ResponsesWatFed(:,:,2,:),ResponsesWatFed(:,:,4,:),ResponsesWatFed(:,:,6,:)),4));
% 
% RespQuiON=squeeze(mean(cat(3,ResponsesQuiFed(:,:,1,:),ResponsesQuiFed(:,:,3,:),ResponsesQuiFed(:,:,5,:)),4));
% RespQuiOFF=squeeze(mean(cat(3,ResponsesQuiFed(:,:,2,:),ResponsesQuiFed(:,:,4,:),ResponsesQuiFed(:,:,6,:)),4));
% 
% Response=cat(4,RespSucON,RespSucOFF,RespWatON,RespWatOFF,RespQuiON,RespQuiOFF);
% 
% % Calculating Peaks for every trial
% Peaks=squeeze(max(Response([1:30],:,:,:),[],1)-mean(Response([1:15],:,:,:),1));
% 
% PeaksSuc=Peaks(:,:,[1,2]);
% PeaksWat=Peaks(:,:,[3,4]);
% PeaksQui=Peaks(:,:,[5,6]);
% 
% regionslist={'OL';'CX';'LX';'LH';'PENP';'INP';'VMNP';'MB';'AL';'SNP';'VLNP';'GNG'};
% 
% %plotting Peaks as bar chart
% f1=figure;
% 
% for g=1:2
%     subplot(2,1,g);
%     b=bar(PeaksSuc(:,:,g)','FaceColor','flat');
%     legend(regionslist,'Orientation','horizontal','Location','bestoutside');
%     xticklabels({'First','Second','Third'});
%     for k = 1:12
%         b(k).CData = k;
%     end
%     colormap 'jet'
%     ylabel('Mean dF/F','fontsize',14);
%     ylim([0 0.06]);
% end
% sgtitle('Peak Response to Taste (Fed)');
% 
% subplot(2,1,1);
% title('Suc ON');
% 
% subplot(2,1,2);
% title('Suc OFF');
% ylim([0 0.02]);
% 
% 
% f2=figure;
% 
% for g=1:2
%     subplot(2,1,g);
%     b=bar(PeaksWat(:,:,g)','FaceColor','flat');
%     legend(regionslist,'Orientation','horizontal','Location','bestoutside');
%     xticklabels({'First','Second','Third'});
%     for k = 1:12
%         b(k).CData = k;
%     end
%     colormap 'jet'
%     ylabel('Mean dF/F','fontsize',14);
%     ylim([0 0.06]);
% end
% sgtitle('Peak Response to Taste (Fed)');
% 
% subplot(2,1,1);
% title('Wat ON');
% 
% subplot(2,1,2);
% title('Wat OFF');
% ylim([0 0.02]);
% 
% 
% f3=figure;
% 
% for g=1:2
%     subplot(2,1,g);
%     b=bar(PeaksQui(:,:,g)','FaceColor','flat');
%     legend(regionslist,'Orientation','horizontal','Location','bestoutside');
%     xticklabels({'First','Second','Third'});
%     for k = 1:12
%         b(k).CData = k;
%     end
%     colormap 'jet'
%     ylabel('Mean dF/F','fontsize',14);
%     ylim([0 0.06]);
% end
% sgtitle('Peak Response to Taste (Fed)');
% 
% subplot(2,1,1);
% title('Qui ON');
% 
% subplot(2,1,2);
% title('Qui OFF');
% ylim([0 0.02]);