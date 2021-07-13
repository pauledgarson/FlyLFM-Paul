% opens window to select and load multiple datasets
[file,path]=uigetfile('*.mat','Select mean TS mat-file with 12 regions (Fed)','MultiSelect','on','/home/paul/Desktop');
data=strcat(path,file)


for j=1:size(data,2)
load(data{j})
end

TimeSeries193x=cat(1,TimeSeries193,zeros(2,12));
TimeSeries209x=cat(1,TimeSeries209,zeros(1,12));
TimeSeries212x=cat(1,TimeSeries212,zeros(1,12));

%making new arrays containing all the data
TimeSeriesFed=cat(3,TimeSeries184,TimeSeries185,TimeSeries186,TimeSeries193x,TimeSeries194,TimeSeries195,TimeSeries196,TimeSeries197,TimeSeries198,TimeSeries205,TimeSeries206,TimeSeries207,TimeSeries208,TimeSeries209x,TimeSeries210,TimeSeries211,TimeSeries212x,TimeSeries213);

% opens window to select and load multiple datasets
[file,path]=uigetfile('*.mat','Select mean TS mat-file with 12 regions (Starved)','MultiSelect','on','/home/paul/Desktop');
data=strcat(path,file)

for j=1:size(data,2)
load(data{j})
end

TimeSeries224x=cat(1,TimeSeries224,zeros(1,12));

%making new arrays containing all the data
TimeSeriesSta=cat(3,TimeSeries214,TimeSeries215,TimeSeries216,TimeSeries217,TimeSeries218,TimeSeries219,TimeSeries223,TimeSeries224x,TimeSeries225,TimeSeries232,TimeSeries233,TimeSeries234,TimeSeries235,TimeSeries236,TimeSeries237,TimeSeries239,TimeSeries240,TimeSeries241);

%calculation mean and std across animals
MeanBaseSta=mean(TimeSeriesSta,3);
StdBaseSta=std(TimeSeriesSta,0,3);

MeanBaseFed=mean(TimeSeriesFed,3);
StdBaseFed=std(TimeSeriesFed,0,3);


BrainAvgBaseSta=mean(MeanBaseSta,2);
BrainAvgStdBaseSta=mean(StdBaseSta,2);

BrainAvgBaseFed=mean(MeanBaseFed,2);
BrainAvgStdBaseFed=mean(StdBaseFed,2);

regionslist={'OL';'CX';'LX';'LH';'PENP';'INP';'VMNP';'MB';'AL';'SNP';'VLNP';'GNG'};
regions=1:12;

set (0,'DefaultFigureVisible','off');

for i=regions
Red=MeanBaseFed(:,i);
Green=MeanBaseSta(:,i);
[pBase(i),tbBase(:,:,i),~]=anova1([Red, Green]);
end

for i=regions
Red=StdBaseFed(:,i);
Green=StdBaseSta(:,i);
[pSTD(i),tbSTD(:,:,i),~]=anova1([Red, Green]);
end


[pAvgBase,tbAvgBase,~]=anova1([BrainAvgBaseFed,BrainAvgBaseSta]);
[pStdBase,tbStdBase,~]=anova1([BrainAvgStdBaseFed,BrainAvgStdBaseSta]);


delete(get(0,'children'));
set (0,'DefaultFigureVisible','on');


figure (1)

sgtitle('Mean Distribution');
for i=regions
    subplot(3,4,i);
    histogram(MeanBaseSta(:,i),20,'FaceColor','g');
    hold on
    histogram(MeanBaseFed(:,i),20,'FaceColor','r');
    title(regionslist(i));
end

figure (2)

sgtitle('Mean Distribution');
for i=regions
    subplot(3,4,i);
    Base=[MeanBaseSta(:,i)';MeanBaseFed(:,i)']';
    boxplot(Base,'Notch','on','Labels',{'Starved','Fed'});
    title(regionslist(i));
end

figure (3)

sgtitle('STD Distribution');
for i=regions
    subplot(3,4,i);
    histogram(StdBaseSta(:,i),20,'FaceColor','g');
    hold on
    histogram(StdBaseFed(:,i),20,'FaceColor','r');
    title(regionslist(i));
end

figure (4)

sgtitle('STD Distribution');
for i=regions
    subplot(3,4,i);
    STD=[StdBaseSta(:,i)';StdBaseFed(:,i)']';
    boxplot(STD,'Notch','on','Labels',{'Starved','Fed'});
    title(regionslist(i));
end


figure(5)

sgtitle('Mean Distribution (Brain Average)');
subplot(1,2,1);
histogram(BrainAvgBaseSta',20,'FaceColor','g');
hold on
histogram(BrainAvgBaseFed',20,'FaceColor','r');
hold off

subplot(1,2,2);
boxplot(cat(2,BrainAvgBaseSta,BrainAvgBaseFed),'Notch','on','Labels',{'Starved','Fed'});


figure(6)

sgtitle('STD Distribution (Brain Average)');
subplot(1,2,1);
histogram(BrainAvgStdBaseSta',20,'FaceColor','g');
hold on
histogram(BrainAvgStdBaseFed',20,'FaceColor','r');
hold off

subplot(1,2,2);
boxplot(cat(2,BrainAvgStdBaseSta,BrainAvgStdBaseFed),'Notch','on','Labels',{'Starved','Fed'});





