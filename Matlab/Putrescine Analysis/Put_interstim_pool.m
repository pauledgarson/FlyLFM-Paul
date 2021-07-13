% opens window to select and load multiple datasets
[file,path]=uigetfile('*.mat','Select mean TS mat-file with 12 regions (Red)','MultiSelect','on','/home/paul/Desktop/Putrescine Pool');
data=strcat(path,file)

for j=1:size(data,2)
load(data{j})
end

% opens window to select and load multiple datasets
[file,path]=uigetfile('*.mat','Select mean TS mat-file with 12 regions (Green)','MultiSelect','on','/home/paul/Desktop/Putrescine Pool');
data=strcat(path,file)

for j=1:size(data,2)
load(data{j})
end

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


%extracting interstimulus intervals and calculating mean and std across
%animals
FirstBaseGreen=TimeSeriesGreen([600:900],:,:);
SecondBaseGreen=TimeSeriesGreen([1100:1400],:,:);
ThirdBaseGreen=TimeSeriesGreen([1600:1900],:,:);
FourthBaseGreen=TimeSeriesGreen([2100:2400],:,:);

AvgIntervalGreen=cat(1,FirstBaseGreen,SecondBaseGreen,ThirdBaseGreen,FourthBaseGreen);
MeanBaseGreen=mean(AvgIntervalGreen,3);
StdBaseGreen=std(AvgIntervalGreen,0,3);


FirstBaseRed=TimeSeriesRed([600:900],:,:);
SecondBaseRed=TimeSeriesRed([1100:1400],:,:);
ThirdBaseRed=TimeSeriesRed([1600:1900],:,:);
FourthBaseRed=TimeSeriesRed([2100:2400],:,:);

AvgIntervalRed=cat(1,FirstBaseRed,SecondBaseRed,ThirdBaseRed,FourthBaseRed);
MeanBaseRed=mean(AvgIntervalRed,3);
StdBaseRed=std(AvgIntervalRed,0,3);

%Averaging Mean and Std across brain regions
BrainAvgBaseGreen=mean(MeanBaseGreen,2);
BrainAvgStdBaseGreen=mean(StdBaseGreen,2);

BrainAvgBaseRed=mean(MeanBaseRed,2);
BrainAvgStdBaseRed=mean(StdBaseRed,2);

regionslist={'OL';'CX';'LX';'LH';'PENP';'INP';'VMNP';'MB';'AL';'SNP';'VLNP';'GNG'};
regions=1:12;

%performing ANOVA on mean and std between groups per brain region
set (0,'DefaultFigureVisible','off');

for i=regions
Red=MeanBaseRed(:,i);
Green=MeanBaseGreen(:,i);
[pBase(i),tbBase(:,:,i),~]=anova1([Red, Green]);
end

for i=regions
Red=StdBaseRed(:,i);
Green=StdBaseGreen(:,i);
[pSTD(i),tbSTD(:,:,i),~]=anova1([Red, Green]);
end

%ANOVA for brain average (all regions) between groups
[pAvgBase,tbAvgBase,~]=anova1([BrainAvgBaseRed,BrainAvgBaseGreen]);
[pStdBase,tbStdBase,~]=anova1([BrainAvgStdBaseRed,BrainAvgStdBaseGreen]);


delete(get(0,'children'));
set (0,'DefaultFigureVisible','on');

%plotting distribution of values and boxplot 
figure (1)

sgtitle('Interstimulus Mean Baseline Distribution');
for i=regions
    subplot(3,4,i);
    histogram(MeanBaseGreen(:,i),20,'FaceColor','g');
    hold on
    histogram(MeanBaseRed(:,i),20,'FaceColor','r');
    title(regionslist(i));
end

figure (2)

sgtitle('Interstimulus Mean Baseline');
for i=regions
    subplot(3,4,i);
    Base=[MeanBaseGreen(:,i)';MeanBaseRed(:,i)']';
    boxplot(Base,'Notch','on','Labels',{'Mated','Virgin'});
    title(regionslist(i));
end

figure (3)

sgtitle('Interstimulus STD Distribution');
for i=regions
    subplot(3,4,i);
    histogram(StdBaseGreen(:,i),20,'FaceColor','g');
    hold on
    histogram(StdBaseRed(:,i),20,'FaceColor','r');
    title(regionslist(i));
end

figure (4)

sgtitle('Interstimulus STD from Mean Baseline');
for i=regions
    subplot(3,4,i);
    STD=[StdBaseGreen(:,i)';StdBaseRed(:,i)']';
    boxplot(STD,'Notch','on','Labels',{'Mated','Virgin'});
    title(regionslist(i));
end


figure(5)

sgtitle('Interstimulus Mean-Baseline Distribution (Brain Average)');
subplot(1,2,1);
histogram(BrainAvgBaseGreen',20,'FaceColor','g');
hold on
histogram(BrainAvgBaseRed',20,'FaceColor','r');
hold off

subplot(1,2,2);
boxplot(cat(2,BrainAvgBaseGreen,BrainAvgBaseRed),'Notch','on','Labels',{'Mated','Virgin'});


figure(6)

sgtitle('Interstimulus STD from Baseline (Brain Average)');
subplot(1,2,1);
histogram(BrainAvgStdBaseGreen',20,'FaceColor','g');
hold on
histogram(BrainAvgStdBaseRed',20,'FaceColor','r');
hold off

subplot(1,2,2);
boxplot(cat(2,BrainAvgStdBaseGreen,BrainAvgStdBaseRed),'Notch','on','Labels',{'Mated','Virgin'});





