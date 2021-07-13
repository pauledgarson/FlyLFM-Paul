% % opens window to select and load multiple datasets
% [file,path]=uigetfile('*.mat','Select mean TS mat-file with 12 regions (Red)','MultiSelect','on','/home/paul/Desktop/Putrescine Pool');
% data=strcat(path,file)
% 
% for j=1:size(data,2)
% load(data{j})
% end
% 
% % opens window to select and load multiple datasets
% [file,path]=uigetfile('*.mat','Select mean TS mat-file with 12 regions (Green)','MultiSelect','on','/home/paul/Desktop/Putrescine Pool');
% data=strcat(path,file)
% 
% for j=1:size(data,2)
% load(data{j})
% end

TimeSeriesPut309=TimeSeriesPut309([1:3398],:);

%making new arrays containing all the data (mated)
TimeSeriesPaulGr=cat(3,TimeSeriesPut1,TimeSeriesPut5,TimeSeriesPut9,TimeSeriesPut12,TimeSeriesPut13);
TimeSeriesPaulGr=TimeSeriesPaulGr([1:3398],:,:);
TimeSeriesSophieGr=cat(3,TimeSeriesPut305,TimeSeriesPut309);

TimeSeriesGreen=cat(3,TimeSeriesPaulGr,TimeSeriesSophieGr);


%making new arrays containing all the data (virgin)
TimeSeriesPut307=cat(1,zeros(200,12),TimeSeriesPut307);
TimeSeriesPut307=TimeSeriesPut307([1:3398],:);

TimeSeriesPaulRed=cat(3,TimeSeriesPut2,TimeSeriesPut6,TimeSeriesPut7,TimeSeriesPut10,TimeSeriesPut11);
TimeSeriesPaulRed=TimeSeriesPaulRed([1:3398],:,:);
TimeSeriesSophieRed=cat(3,TimeSeriesPut307,TimeSeriesPut308);

TimeSeriesRed=cat(3,TimeSeriesPaulRed,TimeSeriesSophieRed);

StimPeaksRed=cat(3,StimPeaksPut2,StimPeaksPut6,StimPeaksPut7,StimPeaksPut10,StimPeaksPut11,StimPeaks307,StimPeaks308);
StimPeaksGreen=cat(3,StimPeaksPut1,StimPeaksPut5,StimPeaksPut9,StimPeaksPut12,StimPeaksPut13,StimPeaks305,StimPeaks309);

StimPeaks=cat(4,StimPeaksRed,StimPeaksGreen);
StimPeaksVec=reshape(StimPeaks,4*12*7*2,1);

Trials=zeros(4,12,7,2);
for i=1:4
    Trials(i,:,:,:)=i;
end
TrialsVec=reshape(Trials,4*12*7*2,1);

Regions=zeros(4,12,7,2);
for i=1:12
    Regions(:,i,:,:)=i;
end
RegionsVec=reshape(Regions,4*12*7*2,1);

Mating=zeros(4,12,7,2);
for i=1:2
    Mating(:,:,:,i)=i;
end
MatingVec=reshape(Mating,4*12*7*2,1);

anovan(StimPeaksVec,{TrialsVec,RegionsVec,MatingVec},'model','interaction','varnames',{'Trial','Region','Mating'})
boxplot(StimPeaksVec,MatingVec,'Notch','on','Labels',{'Mated','Virgin'});

% post-hoc on mating state
StimPeaksAvRed=mean(mean(StimPeaksRed,1),1);
StimPeaksAvGreen=mean(mean(StimPeaksGreen,1),1);
StimPeaksAvRed=squeeze(mean(squeeze(mean(StimPeaksRed,1)),1));
StimPeaksAvGreen=squeeze(mean(squeeze(mean(StimPeaksGreen,1)),1));
ranksum(StimPeaksAvRed,StimPeaksAvGreen)

%if we don't average it is significant though

%extracting interstimulus intervals and calculating mean and std across
%animals
FirstBaseGreen=TimeSeriesGreen([600:900],:,:);
SecondBaseGreen=TimeSeriesGreen([1100:1400],:,:);
ThirdBaseGreen=TimeSeriesGreen([1600:1900],:,:);
FourthBaseGreen=TimeSeriesGreen([2100:2400],:,:);

AvgIntervalGreen=cat(1,FirstBaseGreen,SecondBaseGreen,ThirdBaseGreen,FourthBaseGreen);

StdBaseGreen=squeeze(std(AvgIntervalGreen,0,1));


FirstBaseRed=TimeSeriesRed([600:900],:,:);
SecondBaseRed=TimeSeriesRed([1100:1400],:,:);
ThirdBaseRed=TimeSeriesRed([1600:1900],:,:);
FourthBaseRed=TimeSeriesRed([2100:2400],:,:);

AvgIntervalRed=cat(1,FirstBaseRed,SecondBaseRed,ThirdBaseRed,FourthBaseRed);

StdBaseRed=squeeze(std(AvgIntervalRed,0,1));

%Averaging Mean and Std across brain regions

BrainAvgStdBaseGreen=mean(StdBaseGreen,1);

BrainAvgStdBaseRed=mean(StdBaseRed,1);

regionslist={'OL';'CX';'LX';'LH';'PENP';'INP';'VMNP';'MB';'AL';'SNP';'VLNP';'GNG'};
regions=1:12;

%performing ANOVA on mean and std between groups per brain region
set (0,'DefaultFigureVisible','off');


% for i=regions
% Red=StdBaseRed(i,:);
% Green=StdBaseGreen(i,:);
% CellsforAnova(i,1:7)=StdBaseRed(i,:);
% CellsforAnova(i,8:14)=StdBaseGreen(i,:);
% [pSTD(i),tbSTD(:,:,i),~]=anova1([Red, Green]);
% end

% %% ANOVA for brain average (all regions) between groups
% 
% [pStdBase,tbStdBase,~]=anova2(CellsforAnova',7);
% 
% 
% delete(get(0,'children'));
% set (0,'DefaultFigureVisible','on');

%% plotting distribution of values and boxplot 


% figure (1)
% 
% sgtitle('Interstimulus STD Distribution');
% for i=regions
%     subplot(3,4,i);
%     histogram(StdBaseGreen(i,:),20,'FaceColor','g');
%     hold on
%     histogram(StdBaseRed(i,:),20,'FaceColor','r');
%     title(regionslist(i));
% end
% 
% figure (2)
% 
% sgtitle('Interstimulus STD from Baseline');
% for i=regions
%     subplot(3,4,i);
%     STD=[StdBaseGreen(i,:);StdBaseRed(i,:)]';
% 
%     boxplot(STD,'Notch','on','Labels',{'Mated','Virgin'});
%     title(regionslist(i));
% end
% 
% figure(3)
% 
% sgtitle('Interstimulus STD from Baseline (Brain Average)');
% subplot(1,2,1);
% histogram(BrainAvgStdBaseGreen,20,'FaceColor','g');
% hold on
% histogram(BrainAvgStdBaseRed,20,'FaceColor','r');
% hold off
% 
% subplot(1,2,2);
% boxplot(cat(2,BrainAvgStdBaseGreen',BrainAvgStdBaseRed'),'Notch','on','Labels',{'Mated','Virgin'});
% 
% 
% 
% figure(4)
% 
% sgtitle('Interstimulus STD from Baseline (All regions)');
% subplot(1,2,1);
% histogram(reshape(StdBaseGreen,12*7,1),20,'FaceColor','g');
% hold on
% histogram(reshape(StdBaseRed,12*7,1),20,'FaceColor','r');
% hold off
% 
% subplot(1,2,2);
% boxplot(cat(2,reshape(StdBaseGreen,12*7,1),reshape(StdBaseRed,12*7,1)),'Notch','on','Labels',{'Mated','Virgin'});




