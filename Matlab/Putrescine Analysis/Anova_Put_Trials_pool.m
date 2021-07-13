%% Calculating and plotting Boxplots of the Peak response over different trials/animals for Putrescine Data
% opens window to select and load multiple datasets
[file,path]=uigetfile('*.mat','Select meanPeaks mat-file with 12 regions (Red)','MultiSelect','on','/home/paul/Desktop/Putrescine Pool');
data=strcat(path,file)

for j=1:size(data,2)
load(data{j})
end

%making new arrays containing all the data
StimPeaksRed=cat(3,StimPeaksPut2,StimPeaksPut6,StimPeaksPut7,StimPeaksPut10,StimPeaksPut11,StimPeaks307,StimPeaks308);

regionslist={'OL';'CX';'LX';'LH';'PENP';'INP';'VMNP';'MB';'AL';'SNP';'VLNP';'GNG'};

FirstStimPeaksRed=reshape(StimPeaksRed(1,:,:),[12,7])';
SecondStimPeaksRed=reshape(StimPeaksRed(2,:,:),[12,7])';
ThirdStimPeaksRed=reshape(StimPeaksRed(3,:,:),[12,7])';
FourthStimPeaksRed=reshape(StimPeaksRed(4,:,:),[12,7])';

% opens window to select and load multiple datasets
[file,path]=uigetfile('*.mat','Select meanPeaks mat-file with 12 regions (Green)','MultiSelect','on','/home/paul/Desktop/Putrescine Pool');
data=strcat(path,file)

for j=1:size(data,2)
load(data{j})
end

%making new arrays containing all the data
StimPeaksGreen=cat(3,StimPeaksPut1,StimPeaksPut5,StimPeaksPut9,StimPeaksPut12,StimPeaksPut13,StimPeaks305,StimPeaks309);

regionslist={'OL';'CX';'LX';'LH';'PENP';'INP';'VMNP';'MB';'AL';'SNP';'VLNP';'GNG'};

FirstStimPeaksGreen=reshape(StimPeaksGreen(1,:,:),[12,7])';
SecondStimPeaksGreen=reshape(StimPeaksGreen(2,:,:),[12,7])';
ThirdStimPeaksGreen=reshape(StimPeaksGreen(3,:,:),[12,7])';
FourthStimPeaksGreen=reshape(StimPeaksGreen(4,:,:),[12,7])';


set (0,'DefaultFigureVisible','off');

regions=1:12;

regionslist={'OL';'CX';'LX';'LH';'PENP';'INP';'VMNP';'MB';'AL';'SNP';'VLNP';'GNG'};


for i=regions
    PeaksGreen=[FirstStimPeaksGreen(:,i)';SecondStimPeaksGreen(:,i)';
        ThirdStimPeaksGreen(:,i)';FourthStimPeaksGreen(:,i)']';
    [pg(i),tbg(:,:,i),~]=anova1(PeaksGreen);
end

for i=regions
    PeaksRed=[FirstStimPeaksRed(:,i)';SecondStimPeaksRed(:,i)';
        ThirdStimPeaksRed(:,i)';FourthStimPeaksRed(:,i)']';
    [pr(i),tbr(:,:,i),~]=anova1(PeaksRed);
end

delete(get(0,'children'));
set (0,'DefaultFigureVisible','on');

figure (1)
sgtitle('Peak Response to Putrescine (Mated)');
for i=regions
    subplot(3,4,i);
    PeaksGreen=[FirstStimPeaksGreen(:,i)';SecondStimPeaksGreen(:,i)';
        ThirdStimPeaksGreen(:,i)';FourthStimPeaksGreen(:,i)']';
    boxplot(PeaksGreen);
    title(regionslist(i));
end

figure (2)
sgtitle('Peak Response to Putrescine (Virgin)');
for i=regions
    subplot(3,4,i);
    PeaksRed=[FirstStimPeaksRed(:,i)';SecondStimPeaksRed(:,i)';
        ThirdStimPeaksRed(:,i)';FourthStimPeaksRed(:,i)']';
    boxplot(PeaksRed);
    title(regionslist(i));
end

