% opens window to select and load multiple datasets
[file,path]=uigetfile('*.mat','Select mean TS mat-file with 12 regions (Red)','MultiSelect','on','/home/paul/Subha');
data=strcat(path,file)


for j=1:size(data,2)
load(data{j})
end

% making new arrays containing all the data
TimeSeriesRed=cat(3,TimeSeriesPut2,TimeSeriesPut6,TimeSeriesPut7,TimeSeriesPut10,TimeSeriesPut11);
TimeSeriesRed=TimeSeriesRed([800:3200],:,:);


% opens window to select and load multiple datasets
[file,path]=uigetfile('*.mat','Select mean TS mat-file with 12 regions (Green)','MultiSelect','on','/home/paul/Subha');
data=strcat(path,file)

for j=1:size(data,2)
load(data{j})
end

% making new arrays containing all the data
TimeSeriesGreen=cat(3,TimeSeriesPut1,TimeSeriesPut5,TimeSeriesPut9,TimeSeriesPut12,TimeSeriesPut13);
TimeSeriesGreen=TimeSeriesGreen([800:3200],:,:);

regionslist={'OL';'CX';'LX';'LH';'PENP';'INP';'VMNP';'MB';'AL';'SNP';'VLNP';'GNG'};

load('GCamp6S10ms.mat');
load('PutExpArray.mat');

FrameRate=10;
Ratio=100/FrameRate;
Kernel=GCaMP6sKernel(1:Ratio:200);

PutExpArrayConv=conv(PutExpArray,Kernel);

PutExpArraySmooth=smooth(PutExpArrayConv,4000);
PEAd=PutExpArrayConv-PutExpArraySmooth';
PEAdregressor=PEAd(1:size(PutExpArray,2));

PEAdregressor=cat(2,zeros(1,10),PEAdregressor([800:3190]));



for i=1:12
  model=fitlm(PEAdregressor,TimeSeriesGreen(:,i,1)');
  R2Put1(i)=model.Rsquared.Ordinary;
  COEFPut1(i)=model.Coefficients.Estimate(2);
  PPut1=model.coefTest;
end

for i=1:12
  model=fitlm(PEAdregressor,TimeSeriesGreen(:,i,2)');
  R2Put5(i)=model.Rsquared.Ordinary;
  COEFPut5(i)=model.Coefficients.Estimate(2);
  PPut5=model.coefTest;
end

for i=1:12
  model=fitlm(PEAdregressor,TimeSeriesGreen(:,i,3)');
  R2Put9(i)=model.Rsquared.Ordinary;
  COEFPut9(i)=model.Coefficients.Estimate(2);
  PPut9=model.coefTest;
end

for i=1:12
  model=fitlm(PEAdregressor,TimeSeriesGreen(:,i,4)');
  R2Put12(i)=model.Rsquared.Ordinary;
  COEFPut12(i)=model.Coefficients.Estimate(2);
  PPut12=model.coefTest;
end

for i=1:12
  model=fitlm(PEAdregressor,TimeSeriesGreen(:,i,5)');
  R2Put13(i)=model.Rsquared.Ordinary;
  COEFPut13(i)=model.Coefficients.Estimate(2);
  PPut13=model.coefTest;
end

R2PutGreen=cat(1,R2Put1,R2Put5,R2Put9,R2Put12,R2Put13);
COEFPutGreen=cat(1,COEFPut1,COEFPut5,COEFPut9,COEFPut12,COEFPut13);
PPutGreen=cat(1,PPut1,PPut5,PPut9,PPut12,PPut13);


for i=1:12
  model=fitlm(PEAdregressor,TimeSeriesRed(:,i,1)');
  R2Put2(i)=model.Rsquared.Ordinary;
  COEFPut2(i)=model.Coefficients.Estimate(2);
  PPut2=model.coefTest;
end

for i=1:12
  model=fitlm(PEAdregressor,TimeSeriesRed(:,i,2)');
  R2Put6(i)=model.Rsquared.Ordinary;
  COEFPut6(i)=model.Coefficients.Estimate(2);
  PPut6=model.coefTest;
end

for i=1:12
  model=fitlm(PEAdregressor,TimeSeriesRed(:,i,3)');
  R2Put7(i)=model.Rsquared.Ordinary;
  COEFPut7(i)=model.Coefficients.Estimate(2);
  PPut7=model.coefTest;
end

for i=1:12
  model=fitlm(PEAdregressor,TimeSeriesRed(:,i,4)');
  R2Put10(i)=model.Rsquared.Ordinary;
  COEFPut10(i)=model.Coefficients.Estimate(2);
  PPut10=model.coefTest;
end

for i=1:12
  model=fitlm(PEAdregressor,TimeSeriesRed(:,i,5)');
  R2Put11(i)=model.Rsquared.Ordinary;
  COEFPut11(i)=model.Coefficients.Estimate(2);
  PPut11=model.coefTest;
end

R2PutRed=cat(1,R2Put2,R2Put6,R2Put7,R2Put10,R2Put11);
COEFPutRed=cat(1,COEFPut2,COEFPut6,COEFPut7,COEFPut10,COEFPut11);
PPutRed=cat(1,PPut2,PPut6,PPut7,PPut10,PPut11);


set (0,'DefaultFigureVisible','off');

for i=1:12
R2Red=R2PutRed(:,i);
R2Green=R2PutGreen(:,i);
[pR2(i),tbR2(:,:,i),~]=anova1([R2Red, R2Green]);
end

for i=1:12
COEFRed=COEFPutRed(:,i);
COEFGreen=COEFPutGreen(:,i);
[pCOEF(i),tbCOEF(:,:,i),~]=anova1([COEFRed, COEFGreen]);
end

delete(get(0,'children'));
set (0,'DefaultFigureVisible','on');


% figure (1)
% 
% sgtitle('R-Squared Stimulus-Response')
% for i=1:12
%     subplot(3,4,i)
%     R2=[R2PutGreen(:,i),R2PutRed(:,i)];
%     boxplot(R2,'Labels',{'Green','Red'});
%     title(regionslist(i));
% end
% 
% figure (2)
% 
% sgtitle('Correlation Coefficient Stimulus-Response')
% for i=1:12
%     subplot(3,4,i)
%     COEF=[COEFPutGreen(:,i),COEFPutRed(:,i)];
%     boxplot(COEF,'Labels',{'Green','Red'});
%     title(regionslist(i));
% end

figure (3)

sgtitle('Mean Put Response (mated) and Regressor')
for i=1:5
    subplot(2,3,i);
    plot(PEAdregressor/4000);
    hold on
    plot (mean(TimeSeriesGreen(:,:,i),2),'g');
    hold off
end


figure (4)
sgtitle('Mean Put Response (virgin) and Regressor')

for i=1:5
    subplot(2,3,i);
    plot(PEAdregressor/4000);
    hold on
    plot (mean(TimeSeriesRed(:,:,i),2),'r');
    hold off
end
