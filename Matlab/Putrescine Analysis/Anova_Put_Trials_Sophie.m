% Calculating and plotting Boxplots of the Peak response from functional components over different trials/animals for Putrescine Data
% opens window to select and load multiple datasets
[file,path]=uigetfile('*.mat','Select timeseriescoPeaksComp.mat file for different components','MultiSelect','on','/home/paul/Subha');
data=strcat(path,file)

for j=1:size(data,2)
load(data{j})
end

%making new arrays containing all the data
StimPeaksRed=cat(3,StimPeaks307,StimPeaks308);

FirstStimRed=reshape(StimPeaksRed(1,:,:),[12,2])';
SecStimRed=reshape(StimPeaksRed(2,:,:),[12,2])';
ThirdStimRed=reshape(StimPeaksRed(3,:,:),[12,2])';
FourStimRed=reshape(StimPeaksRed(4,:,:),[12,2])';

% opens window to select and load multiple datasets
[file,path]=uigetfile('*.mat','Select meanPeaks mat-file with 12 regions (Green)','MultiSelect','on','/home/paul/Desktop');
data=strcat(path,file)

for j=1:size(data,2)
load(data{j})
end

%making new arrays containing all the data
StimPeaksGreen=cat(3,StimPeaks305,StimPeaks309);

FirstStimGreen=reshape(StimPeaksGreen(1,:,:),[12,2])';
SecStimGreen=reshape(StimPeaksGreen(2,:,:),[12,2])';
ThirdStimGreen=reshape(StimPeaksGreen(3,:,:),[12,2])';
FourStimGreen=reshape(StimPeaksGreen(4,:,:),[12,2])';


regionslist={'OL';'CX';'LX';'LH';'PENP';'INP';'VMNP';'MB';'AL';'SNP';'VLNP';'GNG'};

regions=1:12;

set (0,'DefaultFigureVisible','off');

for i=regions
    PeaksGreen=[FirstStimGreen(:,i)';SecStimGreen(:,i)';
        ThirdStimGreen(:,i)';FourStimGreen(:,i)']';
    [pg(i),tbg(:,:,i),~]=anova1(PeaksGreen);
end

for i=regions
    PeaksRed=[FirstStimPeaksRed(:,i)';SecStimRed(:,i)';
        ThirdStimRed(:,i)';FourStimRed(:,i)']';
    [pr(i),tbr(:,:,i),~]=anova1(PeaksRed);
end

delete(get(0,'children'));
set (0,'DefaultFigureVisible','on');

figure (1)
sgtitle('Peak Response to Putrescine (Green)');
for i=regions
    subplot(3,4,i);
    PeaksGreen=[FirstStimGreen(:,i)';SecStimGreen(:,i)';
        ThirdStimGreen(:,i)';FourStimGreen(:,i)']';
    boxplot(PeaksGreen);
    title(regionslist(i));
end

figure (2)
sgtitle('Peak Response to Putrescine (Red)');
for i=regions
    subplot(3,4,i);
    PeaksRed=[FirstStimRed(:,i)';SecStimRed(:,i)';
        ThirdStimRed(:,i)';FourStimRed(:,i)']';
    boxplot(PeaksRed);
    title(regionslist(i));
end