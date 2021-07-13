%% Calculating and plotting the Mean Peak response over different trials as scatter plots

% %opens window to select and load multiple datasets
% [file,path]=uigetfile('*.mat','Select TSROImeanPeaks mat-file with 12 regions','MultiSelect','on','/home/paul/Desktop');
% data=strcat(path,file)
% 
% for j=1:size(data,2)
% load(data{j})
% end

% Form all data into array and calculate mean across animals/trials
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
% StimPeaks=cat(3,StimPeaks99,StimPeaks100,StimPeaks101,StimPeaks102,StimPeaks116,StimPeaks117,StimPeaks118,StimPeaks119);
AvgPeaks=mean(StimPeaks_Starved(:,:,[1,9]),3);
regionslist={'OL';'CX';'LX';'LH';'PENP';'INP';'VMNP';'MB';'AL';'SNP';'VLNP';'GNG'};

% Extract data for On responses and plot
PeaksON=StimPeaks_Starved([1 3 5],:,[1,9]);
AVGPeaksON=AvgPeaks([1 3 5],:)';

figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1,...
    'XTickLabel',regionslist,'Fontsize',15,...
    'XTick',[1 2 3 4 5 6 7 8 9 10 11 12]);
hold(axes1,'on');

%plot Peaks
hold on
plot(reshape(PeaksON(1,:,:),[12 2]),'Marker','o','LineWidth',1,'LineStyle','none','Parent',axes1, 'color', 'g');
plot(reshape(PeaksON(2,:,:),[12 2]),'Marker','o','LineWidth',1,'LineStyle','none','Parent',axes1,'color', 'b');
plot(reshape(PeaksON(3,:,:),[12 2]),'Marker','o','LineWidth',1,'LineStyle','none','Parent',axes1,'color', 'r');
p1=plot(AVGPeaksON(:,1),'Marker','o','LineWidth',1,'LineStyle','none','Parent',axes1,'color', 'g','MarkerSize',20, 'MarkerFaceColor','g','MarkerEdgeColor','k');
p2=plot(AVGPeaksON(:,2),'Marker','o','LineWidth',1,'LineStyle','none','Parent',axes1,'color', 'b','MarkerSize',20, 'MarkerFaceColor','b','MarkerEdgeColor','k');
p3=plot(AVGPeaksON(:,3),'Marker','o','LineWidth',1,'LineStyle','none','Parent',axes1,'color', 'r','MarkerSize',20, 'MarkerFaceColor','r','MarkerEdgeColor','k');
hold off

%plot description
title('Peak ON Response to Taste 1st Trial (Starved)');
ylabel({'Mean dF/F'});
legend([p1 p2 p3],{'Suc','Wat','Qui'},'FontSize',18);
xlim([0 13]);
ylim([0 0.3]);

%Extract data for OFF responses and plot
PeaksOFF=StimPeaks_Starved([2 4 6],:,[1,9]);
AVGPeaksOFF=AvgPeaks([2 4 6],:)';

figure2 = figure;

% Create axes
axes1 = axes('Parent',figure2,...
    'XTickLabel',regionslist,'Fontsize',15,...
    'XTick',[1 2 3 4 5 6 7 8 9 10 11 12]);
hold(axes1,'on');

%plot Peaks
hold on
plot(reshape(PeaksOFF(1,:,:),[12 2]),'Marker','o','LineWidth',1,'LineStyle','none','Parent',axes1, 'color', 'g');
plot(reshape(PeaksOFF(2,:,:),[12 2]),'Marker','o','LineWidth',1,'LineStyle','none','Parent',axes1,'color', 'b');
plot(reshape(PeaksOFF(3,:,:),[12 2]),'Marker','o','LineWidth',1,'LineStyle','none','Parent',axes1,'color', 'r');
p1=plot(AVGPeaksOFF(:,1),'Marker','o','LineWidth',1,'LineStyle','none','Parent',axes1,'color', 'g','MarkerSize',20, 'MarkerFaceColor','g','MarkerEdgeColor','k');
p2=plot(AVGPeaksOFF(:,2),'Marker','o','LineWidth',1,'LineStyle','none','Parent',axes1,'color', 'b','MarkerSize',20, 'MarkerFaceColor','b','MarkerEdgeColor','k');
p3=plot(AVGPeaksOFF(:,3),'Marker','o','LineWidth',1,'LineStyle','none','Parent',axes1,'color', 'r','MarkerSize',20, 'MarkerFaceColor','r','MarkerEdgeColor','k');
hold off

%plot description
title('Peak OFF Response to Taste 1st Trial (Starved)');
ylabel({'Mean dF/F'});
legend([p1 p2 p3],{'Suc','Wat','Qui'},'FontSize',18);
xlim([0 13]);
ylim([0 0.03]);


% %Plot Suc Peaks ON/OFF
% figure3=figure;
% 
% % Create axes
% axes1 = axes('Parent',figure3,...
%     'XTickLabel',regionslist,'Fontsize',15,...
%     'XTick',[1 2 3 4 5 6 7 8 9 10 11 12]);
% hold(axes1,'on');
% 
% %plot Peaks
% hold on
% plot(reshape(PeaksON(1,:,:),[12 8]),'Marker','o','LineWidth',1,'LineStyle','none','Parent',axes1, 'color',[0.3 0.5 0.2]);
% plot(reshape(PeaksOFF(1,:,:),[12 8]),'Marker','o','LineWidth',1,'LineStyle','none','Parent',axes1,'color',[0.3 1 0.1]);
% p1=plot(AVGPeaksON(:,1),'Marker','o','LineWidth',1,'LineStyle','none','Parent',axes1,'color', 'g','MarkerSize',20, 'MarkerFaceColor',[0.3 0.5 0.2],'MarkerEdgeColor','k');
% p2=plot(AVGPeaksOFF(:,1),'Marker','o','LineWidth',1,'LineStyle','none','Parent',axes1,'color', 'b','MarkerSize',20, 'MarkerFaceColor',[0.3 1 0.1],'MarkerEdgeColor','k');
% hold off
% 
% %plot description
% title('Peak ON/OFF Response to Sucrose');
% ylabel({'Mean dF/F'});
% legend([p1 p2],{'ON','OFF'},'FontSize',18);
% xlim([0 13]);
% 
% 
% %Plot Wat Peaks ON/OFF
% figure4=figure;
% 
% % Create axes
% axes1 = axes('Parent',figure4,...
%     'XTickLabel',regionslist,'Fontsize',15,...
%     'XTick',[1 2 3 4 5 6 7 8 9 10 11 12]);
% hold(axes1,'on');
% 
% %plot Peaks
% hold on
% plot(reshape(PeaksON(2,:,:),[12 8]),'Marker','o','LineWidth',1,'LineStyle','none','Parent',axes1, 'color',[0.1 0.1 0.8]);
% plot(reshape(PeaksOFF(2,:,:),[12 8]),'Marker','o','LineWidth',1,'LineStyle','none','Parent',axes1,'color',[0.1 0.8 1]);
% p1=plot(AVGPeaksON(:,2),'Marker','o','LineWidth',1,'LineStyle','none','Parent',axes1,'color', 'g','MarkerSize',20, 'MarkerFaceColor',[0.1 0.1 0.8],'MarkerEdgeColor','k');
% p2=plot(AVGPeaksOFF(:,2),'Marker','o','LineWidth',1,'LineStyle','none','Parent',axes1,'color', 'b','MarkerSize',20, 'MarkerFaceColor',[0.1 0.8 1],'MarkerEdgeColor','k');
% hold off
% 
% %plot description
% title('Peak ON/OFF Response to Water');
% ylabel({'Mean dF/F'});
% legend([p1 p2],{'ON','OFF'},'FontSize',18);
% xlim([0 13]);
% 
% 
% %Plot Qui Peaks ON/OFF
% figure5=figure;
% 
% % Create axes
% axes1 = axes('Parent',figure5,...
%     'XTickLabel',regionslist,'Fontsize',15,...
%     'XTick',[1 2 3 4 5 6 7 8 9 10 11 12]);
% hold(axes1,'on');
% 
% %plot Peaks
% hold on
% plot(reshape(PeaksON(3,:,:),[12 8]),'Marker','o','LineWidth',1,'LineStyle','none','Parent',axes1, 'color',[0.8 0 0.1]);
% plot(reshape(PeaksOFF(3,:,:),[12 8]),'Marker','o','LineWidth',1,'LineStyle','none','Parent',axes1,'color',[0.9 0.6 0.2]);
% p1=plot(AVGPeaksON(:,3),'Marker','o','LineWidth',1,'LineStyle','none','Parent',axes1,'color', 'g','MarkerSize',20, 'MarkerFaceColor',[0.8 0 0.1],'MarkerEdgeColor','k');
% p2=plot(AVGPeaksOFF(:,3),'Marker','o','LineWidth',1,'LineStyle','none','Parent',axes1,'color', 'b','MarkerSize',20, 'MarkerFaceColor',[0.9 0.6 0.2],'MarkerEdgeColor','k');
% hold off
% 
% %plot description
% title('Peak ON/OFF Response to Quinine');
% ylabel({'Mean dF/F'});
% legend([p1 p2],{'ON','OFF'},'FontSize',18);
% xlim([0 13]);

