%% Calculating and plotting the Mean Peak response between mated and virgin flies over different trials as scatter plots

% %opens window to select and load multiple datasets
% [file,path]=uigetfile('*.mat','Select TSROI_LHPeaks mat-file','MultiSelect','on','/home/paul/Desktop');
% data=strcat(path,file)
% 
% for j=1:size(data,2)
% load(data{j})
% end

% Form all data into array and calculate mean across animals
StimPeaksMated=cat(3,StimPeaks305,StimPeaks309);
AvgPeaksMated=mean(StimPeaksMated,3);
StimPeaksVirgin=cat(3,StimPeaks307,StimPeaks308,StimPeaks315);
AvgPeaksVirgin=mean(StimPeaksVirgin,3);

regionslist={'AL','AM','PM'};

% Extract data for first stimulation and plot
PeaksFirstMated=StimPeaksMated(1,:,:);
PeaksFirstVirgin=StimPeaksVirgin(1,:,:);

% figure1 = figure;
% 
% % Create axes
% axes1 = axes('Parent',figure1,...
%     'XTickLabel',regionslist,'Fontsize',15,...
%     'XTick',[1 2 3]);
% hold(axes1,'on');
% 
% %plot Peaks
% hold on
% plot(reshape(PeaksFirstMated,[3 2]),'Marker','o','LineWidth',1,'LineStyle','none','Parent',axes1, 'color', 'g');
% plot(reshape(PeaksFirstVirgin,[3 3]),'Marker','o','LineWidth',1,'LineStyle','none','Parent',axes1,'color', 'b');
% 
% p1=plot(AvgPeaksMated(1,:),'Marker','o','LineWidth',1,'LineStyle','none','Parent',axes1,'color', 'g','MarkerSize',20, 'MarkerFaceColor','g','MarkerEdgeColor','k');
% p2=plot(AvgPeaksVirgin(1,:),'Marker','o','LineWidth',1,'LineStyle','none','Parent',axes1,'color', 'b','MarkerSize',20, 'MarkerFaceColor','b','MarkerEdgeColor','k');
% hold off
% 
% %plot description
% title('Peak Response to First Stimulation');
% ylabel({'Mean dF/F'});
% legend([p1 p2],{'Mated','Virgin'},'FontSize',18);
% xlim([0 4]);
% % 
% 
% 
% % Extract data for second stimulation and plot
% PeaksSecondMated=StimPeaksMated(2,:,:);
% PeaksSecondVirgin=StimPeaksVirgin(2,:,:);
% 
% figure2 = figure;
% 
% % Create axes
% axes1 = axes('Parent',figure2,...
%     'XTickLabel',regionslist,'Fontsize',15,...
%     'XTick',[1 2 3]);
% hold(axes1,'on');
% 
% %plot Peaks
% hold on
% plot(reshape(PeaksSecondMated,[3 2]),'Marker','o','LineWidth',1,'LineStyle','none','Parent',axes1, 'color', 'g');
% plot(reshape(PeaksSecondVirgin,[3 3]),'Marker','o','LineWidth',1,'LineStyle','none','Parent',axes1,'color', 'b');
% 
% p1=plot(AvgPeaksMated(2,:),'Marker','o','LineWidth',1,'LineStyle','none','Parent',axes1,'color', 'g','MarkerSize',20, 'MarkerFaceColor','g','MarkerEdgeColor','k');
% p2=plot(AvgPeaksVirgin(2,:),'Marker','o','LineWidth',1,'LineStyle','none','Parent',axes1,'color', 'b','MarkerSize',20, 'MarkerFaceColor','b','MarkerEdgeColor','k');
% hold off
% 
% %plot description
% title('Peak Response to Second Stimulation');
% ylabel({'Mean dF/F'});
% legend([p1 p2],{'Mated','Virgin'},'FontSize',18);
% xlim([0 4]);
% 
% 
% 
% % Extract data for third stimulation and plot
% PeaksThirdMated=StimPeaksMated(3,:,:);
% PeaksThirdVirgin=StimPeaksVirgin(3,:,:);
% 
% figure3=figure;
% 
% % Create axes
% axes1 = axes('Parent',figure3,...
%     'XTickLabel',regionslist,'Fontsize',15,...
%     'XTick',[1 2 3]);
% hold(axes1,'on');
% 
% %plot Peaks
% hold on
% plot(reshape(PeaksThirdMated,[3 2]),'Marker','o','LineWidth',1,'LineStyle','none','Parent',axes1, 'color', 'g');
% plot(reshape(PeaksThirdVirgin,[3 3]),'Marker','o','LineWidth',1,'LineStyle','none','Parent',axes1,'color', 'b');
% 
% p1=plot(AvgPeaksMated(3,:),'Marker','o','LineWidth',1,'LineStyle','none','Parent',axes1,'color', 'g','MarkerSize',20, 'MarkerFaceColor','g','MarkerEdgeColor','k');
% p2=plot(AvgPeaksVirgin(3,:),'Marker','o','LineWidth',1,'LineStyle','none','Parent',axes1,'color', 'b','MarkerSize',20, 'MarkerFaceColor','b','MarkerEdgeColor','k');
% hold off
% 
% %plot description
% title('Peak Response to Third Stimulation');
% ylabel({'Mean dF/F'});
% legend([p1 p2],{'Mated','Virgin'},'FontSize',18);
% xlim([0 4]);
%  
% 
% 
% % Extract data for fourth stimulation and plot
% PeaksFourthMated=StimPeaksMated(4,:,:);
% PeaksFourthVirgin=StimPeaksVirgin(4,:,:);
% 
% figure4=figure;
% 
% % Create axes
% axes1 = axes('Parent',figure4,...
%     'XTickLabel',regionslist,'Fontsize',15,...
%     'XTick',[1 2 3]);
% hold(axes1,'on');
% 
% %plot Peaks
% hold on
% plot(reshape(PeaksFourthMated,[3 2]),'Marker','o','LineWidth',1,'LineStyle','none','Parent',axes1, 'color', 'g');
% plot(reshape(PeaksFourthVirgin,[3 3]),'Marker','o','LineWidth',1,'LineStyle','none','Parent',axes1,'color', 'b');
% 
% p1=plot(AvgPeaksMated(4,:),'Marker','o','LineWidth',1,'LineStyle','none','Parent',axes1,'color', 'g','MarkerSize',20, 'MarkerFaceColor','g','MarkerEdgeColor','k');
% p2=plot(AvgPeaksVirgin(4,:),'Marker','o','LineWidth',1,'LineStyle','none','Parent',axes1,'color', 'b','MarkerSize',20, 'MarkerFaceColor','b','MarkerEdgeColor','k');
% hold off
% 
% %plot description
% title('Peak Response to Fourth Stimulation');
% ylabel({'Mean dF/F'});
% legend([p1 p2],{'Mated','Virgin'},'FontSize',18);
% xlim([0 4]);



% Plot average response over all stimulations
AvgPeaksMatedAllFlies=mean(StimPeaksMated,1);
AvgPeaksVirginAllFlies=mean(StimPeaksVirgin,1);

figure5=figure;

% Create axes
axes1 = axes('Parent',figure5,...
    'XTickLabel',regionslist,'Fontsize',15,...
    'XTick',[1 2 3]);
hold(axes1,'on');

% %plot Peaks
hold on
plot(reshape(AvgPeaksMatedAllFlies,[3 2]),'Marker','o','LineWidth',1,'LineStyle','none','Parent',axes1, 'color', 'g');
plot(reshape(AvgPeaksVirginAllFlies,[3 3]),'Marker','o','LineWidth',1,'LineStyle','none','Parent',axes1,'color', 'b');

p1=plot(mean(AvgPeaksMatedAllFlies,3),'Marker','o','LineWidth',1,'LineStyle','none','Parent',axes1,'color', 'g','MarkerSize',20, 'MarkerFaceColor','g','MarkerEdgeColor','k');
p2=plot(mean(AvgPeaksVirginAllFlies,3),'Marker','o','LineWidth',1,'LineStyle','none','Parent',axes1,'color', 'b','MarkerSize',20, 'MarkerFaceColor','b','MarkerEdgeColor','k');
hold off

%plot description
title('Peak Response over all Stimulations');
ylabel({'Mean dF/F'});
legend([p1 p2],{'Mated','Virgin'},'FontSize',18);
xlim([0 4]);

