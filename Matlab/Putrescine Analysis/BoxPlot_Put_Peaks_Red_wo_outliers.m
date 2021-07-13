%% Calculating and plotting Boxplots of the Peak response over different trials/animals for Putrescine Data

% % opens window to select and load multiple datasets
% [file,path]=uigetfile('*.mat','Select meanPeaks mat-file with 12 regions','MultiSelect','on','/home/paul/Desktop');
% data=strcat(path,file)
% 
% for j=1:size(data,2)
% load(data{j})
% end

%making new arrays containing all the data
StimPeaks=cat(3,StimPeaksPut7,StimPeaksPut10,StimPeaksPut11);

regionslist={'OL';'CX';'LX';'LH';'PENP';'INP';'VMNP';'MB';'AL';'SNP';'VLNP';'GNG'};

FirstStimPeaks=reshape(StimPeaks(1,:,:),[12,3])';
SecondStimPeaks=reshape(StimPeaks(2,:,:),[12,3])';
ThirdStimPeaks=reshape(StimPeaks(3,:,:),[12,3])';
FourthStimPeaks=reshape(StimPeaks(4,:,:),[12,3])';

f=figure;

subplot(2,2,1);
First=bplot(FirstStimPeaks,'outliers');
legend(First);
set(gca, 'XTick', 1:1:12);
set(gca, 'XTickLabel', regionslist,'FontSize', 12);
ylim([0 0.25]);
title('First');

subplot(2,2,2);
Second=bplot(SecondStimPeaks,'outliers');
legend(Second);
set(gca, 'XTick', 1:1:12);
set(gca, 'XTickLabel', regionslist,'FontSize', 12);
ylim([0 0.25]);
title('Second');

subplot(2,2,3);
Third=bplot(ThirdStimPeaks,'outliers');
legend(Third);
set(gca, 'XTick', 1:1:12);
set(gca, 'XTickLabel', regionslist,'FontSize', 12);
ylim([0 0.25]);
title('Third');

subplot(2,2,4);
Four=bplot(FourthStimPeaks,'outliers');
legend(Four);
set(gca, 'XTick', 1:1:12);
set(gca, 'XTickLabel', regionslist,'FontSize', 12);
ylim([0 0.25]);
title('Fourth');

sgtitle('Response to Putrescine (Virgins, red, n=3)');