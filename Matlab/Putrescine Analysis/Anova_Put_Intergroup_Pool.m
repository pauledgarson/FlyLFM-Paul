% Calculating and plotting Boxplots of the Peak response for different trials/animals for Putrescine Data
% opens window to select and load multiple datasets
[file,path]=uigetfile('*.mat','Select meanPeaks12.mat file (red)','MultiSelect','on','/home/paul/Desktop/Putrescine Pool');
data=strcat(path,file)

for j=1:size(data,2)
load(data{j})
end

%making new arrays containing all the data
StimPeaksRed=cat(3,StimPeaksPut2,StimPeaksPut6,StimPeaksPut7,StimPeaksPut10,StimPeaksPut11,StimPeaks307,StimPeaks308);

FirstStimRed=reshape(StimPeaksRed(1,:,:),[12,7])';
SecStimRed=reshape(StimPeaksRed(2,:,:),[12,7])';
ThirdStimRed=reshape(StimPeaksRed(3,:,:),[12,7])';
FourStimRed=reshape(StimPeaksRed(4,:,:),[12,7])';

% opens window to select and load multiple datasets
[file,path]=uigetfile('*.mat','Select meanPeaks mat-file with 12 regions (Green)','MultiSelect','on','/home/paul/Desktop/Putrescine Pool');
data=strcat(path,file)

for j=1:size(data,2)
load(data{j})
end

%making new arrays containing all the data
StimPeaksGreen=cat(3,StimPeaksPut1,StimPeaksPut5,StimPeaksPut9,StimPeaksPut12,StimPeaksPut13,StimPeaks305,StimPeaks309);

FirstStimGreen=reshape(StimPeaksGreen(1,:,:),[12,7])';
SecStimGreen=reshape(StimPeaksGreen(2,:,:),[12,7])';
ThirdStimGreen=reshape(StimPeaksGreen(3,:,:),[12,7])';
FourStimGreen=reshape(StimPeaksGreen(4,:,:),[12,7])';

regionslist={'OL';'CX';'LX';'LH';'PENP';'INP';'VMNP';'MB';'AL';'SNP';'VLNP';'GNG'};

set (0,'DefaultFigureVisible','off');

comp=1:12;

for i=comp
Red=FirstStimRed(:,i);
Green=FirstStimGreen(:,i);
hr(i)=kstest(Red);
hg(i)=kstest(Green);
[pc1(i),tbc1(:,:,i),~]=anova1([Red, Green]);
%boxplot([Red,Green]);
end

for i=comp
Red=SecStimRed(:,i);
Green=SecStimGreen(:,i);
[pc2(i),tbc2(:,:,i),~]=anova1([Red, Green]);
end

for i=comp
Red=ThirdStimRed(:,i);
Green=ThirdStimGreen(:,i);
[pc3(i),tbc3(:,:,i),~]=anova1([Red, Green]);
end

for i=comp
Red=FourStimRed(:,i);
Green=FourStimGreen(:,i);
[pc4(i),tbc4(:,:,i),~]=anova1([Red, Green]);
end

CumPeakGreen=[FirstStimGreen;SecStimGreen;ThirdStimGreen;FourStimGreen];
CumPeakRed=[FirstStimRed;SecStimRed;ThirdStimRed;FourStimRed];

for i=comp
Red=CumPeakRed(:,i);
Green=CumPeakGreen(:,i);
[pcc(i),tbcc(:,:,i),~]=anova1([Red, Green]);
end

delete(get(0,'children'));
set (0,'DefaultFigureVisible','on');


figure (1)
sgtitle('First Peak Response to Putrescine');
for i=comp
    subplot(3,4,i);
    FirstPeak=[FirstStimGreen(:,i)';FirstStimRed(:,i)']';
    boxplot(FirstPeak,'Labels',{'Mated','Virgin'});
    title(regionslist(i));
end

figure (2)
sgtitle('Second Peak Response to Putrescine');
for i=comp
    subplot(3,4,i);
    SecPeak=[SecStimGreen(:,i)';SecStimRed(:,i)']';
    boxplot(SecPeak,'Labels',{'Mated','Virgin'});
    title(regionslist(i));
end

figure (3)
sgtitle('Third Peak Response to Putrescine');
for i=comp
    subplot(3,4,i);
    ThirdPeak=[ThirdStimGreen(:,i)';ThirdStimRed(:,i)']';
    boxplot(ThirdPeak,'Labels',{'Mated','Virgin'});
    title(regionslist(i));
end

figure (4)
sgtitle('Fourth Peak Response to Putrescine');
for i=comp
    subplot(3,4,i);
    FourPeak=[FourStimGreen(:,i)';FourStimRed(:,i)']';
    boxplot(FourPeak,'Labels',{'Mated','Virgin'});
    title(regionslist(i));
end

figure (5)
sgtitle('Cumulative Peak Response to Putrescine');

for i=comp
    subplot(3,4,i);
    CumulativePeak=[CumPeakGreen(:,i)';CumPeakRed(:,i)']';
    boxplot(CumulativePeak,'Labels',{'Mated','Virgin'});
    title(regionslist(i));
end