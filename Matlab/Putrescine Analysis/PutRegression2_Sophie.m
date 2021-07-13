% % opens window to select and load multiple datasets
% [file,path]=uigetfile('*.mat','Select mean TS mat-file with 12 regions (Red)','MultiSelect','on','/home/paul/Subha');
% data=strcat(path,file)
% 
% 
% for j=1:size(data,2)
% load(data{j})
% end

TimeSeriesPut307shift=cat(1,zeros(200,12),TimeSeriesPut307);
TimeSeriesPut307shiftcrop=TimeSeriesPut307shift([1:3398],:);

% making new arrays containing all the data
TimeSeriesRed=cat(3,TimeSeriesPut307shiftcrop,TimeSeriesPut308);
TimeSeriesRed=TimeSeriesRed([800:3200],:,:);

TimeSeriesPut309=TimeSeriesPut309([1:3398],:);

% making new arrays containing all the data
TimeSeriesGreen=cat(3,TimeSeriesPut305,TimeSeriesPut309);
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

PEAdregressor=PEAdregressor([800:3200]);

for i=1:12
  model=fitlm(PEAdregressor,TimeSeriesGreen(:,i,1)');
  R2Put305(i)=model.Rsquared.Ordinary;
  COEFPut305(i)=model.Coefficients.Estimate(2);
  PPut305=model.coefTest;
end

for i=1:12
  model=fitlm(PEAdregressor,TimeSeriesGreen(:,i,2)');
  R2Put309(i)=model.Rsquared.Ordinary;
  COEFPut309(i)=model.Coefficients.Estimate(2);
  PPut309=model.coefTest;
end


R2PutGreen=cat(1,R2Put305,R2Put309);
COEFPutGreen=cat(1,COEFPut305,COEFPut309);
PPutGreen=cat(1,PPut305,PPut309);


for i=1:12
  model=fitlm(PEAdregressor,TimeSeriesRed(:,i,1)');
  R2Put307(i)=model.Rsquared.Ordinary;
  COEFPut307(i)=model.Coefficients.Estimate(2);
  PPut307=model.coefTest;
end

for i=1:12
  model=fitlm(PEAdregressor,TimeSeriesRed(:,i,2)');
  R2Put308(i)=model.Rsquared.Ordinary;
  COEFPut308(i)=model.Coefficients.Estimate(2);
  PPut308=model.coefTest;
end


R2PutRed=cat(1,R2Put307,R2Put308);
COEFPutRed=cat(1,COEFPut307,COEFPut308);
PPutRed=cat(1,PPut307,PPut308);


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


figure (1)

sgtitle('R-Squared Stimulus-Response')
for i=1:12
    subplot(3,4,i)
    R2=[R2PutGreen(:,i),R2PutRed(:,i)];
    boxplot(R2,'Labels',{'Green','Red'});
    title(regionslist(i));
end

figure (2)

sgtitle('Correlation Coefficient Stimulus-Response')
for i=1:12
    subplot(3,4,i)
    COEF=[COEFPutGreen(:,i),COEFPutRed(:,i)];
    boxplot(COEF,'Labels',{'Green','Red'});
    title(regionslist(i));
end

figure (3)

sgtitle('Mean Put Response (mated) and Regressor')
for i=1:2
    subplot(1,2,i);
    plot(PEAdregressor/4000);
    hold on
    plot (mean(TimeSeriesGreen(:,:,i),2),'g');
    hold off
end


figure (4)
sgtitle('Mean Put Response (virgin) and Regressor')

for i=1:2
    subplot(1,2,i);
    plot(PEAdregressor/4000);
    hold on
    plot (mean(TimeSeriesRed(:,:,i),2),'r');
    hold off
end
