% Calculating and plotting Boxplots of the Peak response from functional components over different trials/animals for Putrescine Data
% opens window to select and load multiple datasets
[file,path]=uigetfile('*.mat','Select timeseriescoPeaksComp.mat file for different components','MultiSelect','on','/home/paul/Subha');
data=strcat(path,file)

for j=1:size(data,2)
load(data{j})
end

GreenLH=[StimPeaksPutCompLH1,StimPeaksPutCompLH12,StimPeaksPutCompLH13]';
GreenMB=[StimPeaksPutCompMB1,StimPeaksPutCompMB12,StimPeaksPutCompMB13]';
GreenCX=[StimPeaksPutCompCX1,StimPeaksPutCompCX12,StimPeaksPutCompCX13]';
GreenGNG=[StimPeaksPutCompGNG1,StimPeaksPutCompGNG12,StimPeaksPutCompGNG13]';

RedLH=[StimPeaksPutCompLH7,StimPeaksPutCompLH10,StimPeaksPutCompLH11]';
RedMB=[StimPeaksPutCompMB7,StimPeaksPutCompMB10,StimPeaksPutCompMB11]';
RedCX=[StimPeaksPutCompCX7,StimPeaksPutCompCX10,StimPeaksPutCompCX11]';
RedGNG=[StimPeaksPutCompGNG7,StimPeaksPutCompGNG10,StimPeaksPutCompGNG11]';

GreenComp=cat(3,GreenLH,GreenMB,GreenCX,GreenGNG);
RedComp=cat(3,RedLH,RedMB,RedCX,RedGNG);

FirstStimGreen=reshape(GreenComp(:,1,:),[3,4]);
SecStimGreen=reshape(GreenComp(:,2,:),[3,4]);
ThirdStimGreen=reshape(GreenComp(:,3,:),[3,4]);
FourStimGreen=reshape(GreenComp(:,4,:),[3,4]);

FirstStimRed=reshape(RedComp(:,1,:),[3,4]);
SecStimRed=reshape(RedComp(:,2,:),[3,4]);
ThirdStimRed=reshape(RedComp(:,3,:),[3,4]);
FourStimRed=reshape(RedComp(:,4,:),[3,4]);

set (0,'DefaultFigureVisible','off');

comp=1:4;

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

complist={'LH','MB','CX','GNG'};

delete(get(0,'children'));
set (0,'DefaultFigureVisible','on');


figure (1)
sgtitle('First Peak Response to Putrescine');
for i=comp
    subplot(2,2,i);
    FirstPeak=[FirstStimGreen(:,i)';FirstStimRed(:,i)']';
    boxplot(FirstPeak,'Labels',{'Green','Red'});
    title(complist(i));
end

figure (2)
sgtitle('Second Peak Response to Putrescine');
for i=comp
    subplot(2,2,i);
    SecPeak=[SecStimGreen(:,i)';SecStimRed(:,i)']';
    boxplot(SecPeak,'Labels',{'Green','Red'});
    title(complist(i));
end

figure (3)
sgtitle('Third Peak Response to Putrescine');
for i=comp
    subplot(2,2,i);
    ThirdPeak=[ThirdStimGreen(:,i)';ThirdStimRed(:,i)']';
    boxplot(ThirdPeak,'Labels',{'Green','Red'});
    title(complist(i));
end

figure (4)
sgtitle('Fourth Peak Response to Putrescine');
for i=comp
    subplot(2,2,i);
    FourPeak=[FourStimGreen(:,i)';FourStimRed(:,i)']';
    boxplot(FourPeak,'Labels',{'Green','Red'});
    title(complist(i));
end

figure (5)
sgtitle('Cumulative Peak Response to Putrescine');


for i=comp
    subplot(2,2,i);
    CumulativePeak=[CumPeakGreen(:,i)';CumPeakRed(:,i)']';
    boxplot(CumulativePeak,'Labels',{'Green','Red'});
    title(complist(i));
end