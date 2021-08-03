%% Calculating and plotting the Mean Peak response between different trials

% opens window to select and load multiple datasets
[file,path]=uigetfile('*.mat','Select TSROImeanPeaks mat-file with 12 regions','MultiSelect','on','/home/paul/Desktop');
data=strcat(path,file)

for j=1:size(data,2)
load(data{j})
end

ResponsesSucSta=cat(4,StimResponses214,StimResponses219,StimResponses225,StimResponses232,StimResponses237,StimResponses239);
ResponsesWatSta=cat(4,StimResponses215,StimResponses218,StimResponses224,StimResponses233,StimResponses236,StimResponses240);
ResponsesQuiSta=cat(4,StimResponses216,StimResponses217,StimResponses223,StimResponses234,StimResponses235,StimResponses241);

%calculating Peaks for every stimulus and animal (region x stimulus x animal)
PeaksSucSta=squeeze(max(ResponsesSucSta([1:30],:,:,:),[],1)-mean(ResponsesSucSta([1:15],:,:,:),1));
PeaksWatSta=squeeze(max(ResponsesWatSta([1:30],:,:,:),[],1)-mean(ResponsesWatSta([1:15],:,:,:),1));
PeaksQuiSta=squeeze(max(ResponsesQuiSta([1:30],:,:,:),[],1)-mean(ResponsesQuiSta([1:15],:,:,:),1));

%saving each peak as one matrix (region x animal)
SucFirstOn=squeeze(PeaksSucSta(:,1,:));
SucFirstOff=squeeze(PeaksSucSta(:,2,:));
SucSecOn=squeeze(PeaksSucSta(:,3,:));
SucSecOff=squeeze(PeaksSucSta(:,4,:));
SucThirdOn=squeeze(PeaksSucSta(:,5,:));
SucThirdOff=squeeze(PeaksSucSta(:,6,:));

WatFirstOn=squeeze(PeaksWatSta(:,1,:));
WatFirstOff=squeeze(PeaksWatSta(:,2,:));
WatSecOn=squeeze(PeaksWatSta(:,3,:));
WatSecOff=squeeze(PeaksWatSta(:,4,:));
WatThirdOn=squeeze(PeaksWatSta(:,5,:));
WatThirdOff=squeeze(PeaksWatSta(:,6,:));

QuiFirstOn=squeeze(PeaksQuiSta(:,1,:));
QuiFirstOff=squeeze(PeaksQuiSta(:,2,:));
QuiSecOn=squeeze(PeaksQuiSta(:,3,:));
QuiSecOff=squeeze(PeaksQuiSta(:,4,:));
QuiThirdOn=squeeze(PeaksQuiSta(:,5,:));
QuiThirdOff=squeeze(PeaksQuiSta(:,6,:));


% % averaging over animals for every trial
% RespSucON=squeeze(mean(cat(3,ResponsesSucSta(:,:,1,:),ResponsesSucSta(:,:,3,:),ResponsesSucSta(:,:,5,:)),4));
% RespSucOFF=squeeze(mean(cat(3,ResponsesSucSta(:,:,2,:),ResponsesSucSta(:,:,4,:),ResponsesSucSta(:,:,6,:)),4));
% 
% RespWatON=squeeze(mean(cat(3,ResponsesWatSta(:,:,1,:),ResponsesWatSta(:,:,3,:),ResponsesWatSta(:,:,5,:)),4));
% RespWatOFF=squeeze(mean(cat(3,ResponsesWatSta(:,:,2,:),ResponsesWatSta(:,:,4,:),ResponsesWatSta(:,:,6,:)),4));
% 
% RespQuiON=squeeze(mean(cat(3,ResponsesQuiSta(:,:,1,:),ResponsesQuiSta(:,:,3,:),ResponsesQuiSta(:,:,5,:)),4));
% RespQuiOFF=squeeze(mean(cat(3,ResponsesQuiSta(:,:,2,:),ResponsesQuiSta(:,:,4,:),ResponsesQuiSta(:,:,6,:)),4));
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
% sgtitle('Peak Response to Taste (Starved)');
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
% sgtitle('Peak Response to Taste (Starved)');
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
% sgtitle('Peak Response to Taste (Starved)');
% 
% subplot(2,1,1);
% title('Qui ON');
% 
% subplot(2,1,2);
% title('Qui OFF');
% ylim([0 0.02]);