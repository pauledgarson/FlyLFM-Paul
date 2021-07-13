% % Calculating and plotting Boxplots of the Peak response from functional components over different trials/animals for Putrescine Data
% % opens window to select and load multiple datasets
% [file,path]=uigetfile('*.mat','Select timeseriescoPeaksComp.mat file for different components','MultiSelect','on','/home/paul/Subha');
% data=strcat(path,file)
% 
% for j=1:size(data,2)
% load(data{j})
% end

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

set (0,'DefaultFigureVisible','off');

comp=1:4;

for i=comp
    GComp=GreenComp(:,:,i);
    [pgc(i),tbgc(:,:,i),~]=anova1(GComp);
end

for i=comp
    RComp=RedComp(:,:,i);
    [prc(i),tbrc(:,:,i),~]=anova1(RComp);
end

delete(get(0,'children'));
set (0,'DefaultFigureVisible','on');

complist={'LH','MB','CX','GNG'};

figure (1)
sgtitle('Peak Response to Putrescine (Green, Components)');
for i=comp
    subplot(2,2,i);
    PeaksG=GreenComp(:,:,i);
    boxplot(PeaksG);
    title(complist(i));
    ylim([0 4]);
end


figure (2)
sgtitle('Peak Response to Putrescine (Red, Components)');
for i=comp
    subplot(2,2,i);
    PeaksR=RedComp(:,:,i);
    boxplot(PeaksR);
    title(complist(i));
    ylim([0 2]);
end