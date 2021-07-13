%% Calculating and plotting Boxplots of the Peak response over different trials/animals for Putrescine Data
% opens window to select and load multiple datasets
[file,path]=uigetfile('*.mat','Select meanPeaks mat-file with 12 regions (Red)','MultiSelect','on','/home/paul/Subha');
data=strcat(path,file)

for j=1:size(data,2)
load(data{j})
end

%making new arrays containing all the data
StimPeaksRed=cat(3,StimPeaksPut2,StimPeaksPut6,StimPeaksPut7,StimPeaksPut10,StimPeaksPut11);

regionslist={'OL';'CX';'LX';'LH';'PENP';'INP';'VMNP';'MB';'AL';'SNP';'VLNP';'GNG'};

FirstStimPeaksRed=reshape(StimPeaksRed(1,:,:),[12,5])';
SecondStimPeaksRed=reshape(StimPeaksRed(2,:,:),[12,5])';
ThirdStimPeaksRed=reshape(StimPeaksRed(3,:,:),[12,5])';
FourthStimPeaksRed=reshape(StimPeaksRed(4,:,:),[12,5])';

% opens window to select and load multiple datasets
[file,path]=uigetfile('*.mat','Select meanPeaks mat-file with 12 regions (Green)','MultiSelect','on','/home/paul/Subha');
data=strcat(path,file)

for j=1:size(data,2)
load(data{j})
end

%making new arrays containing all the data
StimPeaksGreen=cat(3,StimPeaksPut1,StimPeaksPut5,StimPeaksPut9,StimPeaksPut12,StimPeaksPut13);

regionslist={'OL';'CX';'LX';'LH';'PENP';'INP';'VMNP';'MB';'AL';'SNP';'VLNP';'GNG'};

FirstStimPeaksGreen=reshape(StimPeaksGreen(1,:,:),[12,5])';
SecondStimPeaksGreen=reshape(StimPeaksGreen(2,:,:),[12,5])';
ThirdStimPeaksGreen=reshape(StimPeaksGreen(3,:,:),[12,5])';
FourthStimPeaksGreen=reshape(StimPeaksGreen(4,:,:),[12,5])';


SecondStimPeaksCum=table(SecondStimPeaksRed, SecondStimPeaksGreen);
ThirdStimPeaksCum=table(ThirdStimPeaksRed, ThirdStimPeaksGreen);
FourthStimPeaksCum=table(FourthStimPeaksRed, FourthStimPeaksGreen);

set (0,'DefaultFigureVisible','off');

regions=1:12;

% for i=regions
% Red=FirstStimPeaksRed(:,i);
% Green=FirstStimPeaksGreen(:,i);
% hr(i)=kstest(Red);
% hg(i)=kstest(Green);
% [p1(i),tb1(:,:,i),~]=anova1([Red, Green]);
% %boxplot([Red,Green]);
% end
% 
% for i=regions
% Red=SecondStimPeaksRed(:,i);
% Green=SecondStimPeaksGreen(:,i);
% [p2(i),tb2(:,:,i),~]=anova1([Red, Green]);
% end
% 
% for i=regions
% Red=ThirdStimPeaksRed(:,i);
% Green=ThirdStimPeaksGreen(:,i);
% [p3(i),tb3(:,:,i),~]=anova1([Red, Green]);
% end
% 
% for i=regions
% Red=FourthStimPeaksRed(:,i);
% Green=FourthStimPeaksGreen(:,i);
% [p4(i),tb4(:,:,i),~]=anova1([Red, Green]);
% end

% 
% figure(1);
% for i=regions
% Red=FirstStimPeaksRed(:,i);
% Green=FirstStimPeaksGreen(:,i);
% subplot(3,4,i);
% boxplot([Red,Green]);
% end
% 
% 
% 
% figure(2);
% for i=regions
% Red=SecondStimPeaksRed(:,i);
% Green=SecondStimPeaksGreen(:,i);
% subplot(3,4,i);
% boxplot([Red,Green]);
% end
% 
% figure(3);
% for i=regions
% Red=ThirdStimPeaksRed(:,i);
% Green=ThirdStimPeaksGreen(:,i);
% subplot(3,4,i);
% boxplot([Red,Green]);
% end
% 
% figure(4);
% for i=regions
% Red=FourthStimPeaksRed(:,i);
% Green=FourthStimPeaksGreen(:,i);
% subplot(3,4,i);
% boxplot([Red,Green]);
% end
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
sgtitle('Peak Response to Putrescine (Green)');
for i=regions
    subplot(3,4,i);
    PeaksGreen=[FirstStimPeaksGreen(:,i)';SecondStimPeaksGreen(:,i)';
        ThirdStimPeaksGreen(:,i)';FourthStimPeaksGreen(:,i)']';
    boxplot(PeaksGreen);
    title(regionslist(i));
end

figure (2)
sgtitle('Peak Response to Putrescine (Red)');
for i=regions
    subplot(3,4,i);
    PeaksRed=[FirstStimPeaksRed(:,i)';SecondStimPeaksRed(:,i)';
        ThirdStimPeaksRed(:,i)';FourthStimPeaksRed(:,i)']';
    boxplot(PeaksRed);
    title(regionslist(i));
end





% legend(First);
% set(gca, 'XTick', 1:1:12);
% set(gca, 'XTickLabel', regionslist,'FontSize', 12);
% ylim([0 0.25]);
% title('First');

%sgtitle('Response to Putrescine (Virgins, green, n=4)');