% opens window to select and load multiple datasets
[file,path]=uigetfile('*.mat','Select mean TS mat-file with 12 regions (Red)','MultiSelect','on','/home/paul/Subha');
data=strcat(path,file)


for j=1:size(data,2)
load(data{j})
end

% making new arrays containing all the data
TimeSeriesRed=cat(3,TimeSeriesPut2,TimeSeriesPut6,TimeSeriesPut7,TimeSeriesPut10,TimeSeriesPut11);

regionslist={'OL';'CX';'LX';'LH';'PENP';'INP';'VMNP';'MB';'AL';'SNP';'VLNP';'GNG'};

% opens window to select and load multiple datasets
[file,path]=uigetfile('*.mat','Select mean TS mat-file with 12 regions (Green)','MultiSelect','on','/home/paul/Subha');
data=strcat(path,file)

for j=1:size(data,2)
load(data{j})
end

% making new arrays containing all the data
TimeSeriesGreen=cat(3,TimeSeriesPut1,TimeSeriesPut5,TimeSeriesPut9,TimeSeriesPut12,TimeSeriesPut13);


load('GCamp6S10ms.mat');
load('PutExpArray.mat');

FrameRate=10;
Ratio=100/FrameRate;
Kernel=GCaMP6sKernel(1:Ratio:200);

PutExpArrayConv=conv(PutExpArray,Kernel);

PutExpArraySmooth=smooth(PutExpArrayConv,4000);
PEAd=PutExpArrayConv-PutExpArraySmooth';
PEAdregressor=PEAd(1:size(PutExpArray,2));

plot(PEAdregressor)

% 
% for i=1:12
%   model=fitlm(PEAdregressor,TimeSeriesPut1(:,i)');
%   R2Put1(i)=model.Rsquared.Ordinary;
%   COEFPut1(i)=model.Coefficients.Estimate(2);
% end
% 
% for i=1:12
%   model=fitlm(PEAdregressor,TimeSeriesPut5(:,i)');
%   R2Put5(i)=model.Rsquared.Ordinary;
%   COEFPut5(i)=model.Coefficients.Estimate(2);
% end
% 
% for i=1:12
%   model=fitlm(PEAdregressor,TimeSeriesPut9(:,i)');
%   R2Put9(i)=model.Rsquared.Ordinary;
%   COEFPut9(i)=model.Coefficients.Estimate(2);
% end
% 
% for i=1:12
%   model=fitlm(PEAdregressor,TimeSeriesPut12(:,i)');
%   R2Put12(i)=model.Rsquared.Ordinary;
%   COEFPut12(i)=model.Coefficients.Estimate(2);
% end
% 
% for i=1:12
%   model=fitlm(PEAdregressor,TimeSeriesPut13(:,i)');
%   R2Put13(i)=model.Rsquared.Ordinary;
%   COEFPut13(i)=model.Coefficients.Estimate(2);
% end
% 
% R2PutGreen=cat(1,R2Put1,R2Put5,R2Put9,R2Put12,R2Put13);
% COEFPutGreen=cat(1,COEFPut1,COEFPut5,COEFPut9,COEFPut12,COEFPut13);
% 
% 
% for i=1:12
%   model=fitlm(PEAdregressor,TimeSeriesPut2(:,i)');
%   R2Put2(i)=model.Rsquared.Ordinary;
%   COEFPut2(i)=model.Coefficients.Estimate(2);
% end
% 
% for i=1:12
%   model=fitlm(PEAdregressor,TimeSeriesPut6(:,i)');
%   R2Put6(i)=model.Rsquared.Ordinary;
%   COEFPut6(i)=model.Coefficients.Estimate(2);
% end
% 
% for i=1:12
%   model=fitlm(PEAdregressor,TimeSeriesPut7(:,i)');
%   R2Put7(i)=model.Rsquared.Ordinary;
%   COEFPut7(i)=model.Coefficients.Estimate(2);
% end
% 
% for i=1:12
%   model=fitlm(PEAdregressor,TimeSeriesPut10(:,i)');
%   R2Put10(i)=model.Rsquared.Ordinary;
%   COEFPut10(i)=model.Coefficients.Estimate(2);
% end
% 
% for i=1:12
%   model=fitlm(PEAdregressor,TimeSeriesPut11(:,i)');
%   R2Put11(i)=model.Rsquared.Ordinary;
%   COEFPut11(i)=model.Coefficients.Estimate(2);
% end
% 
% R2PutRed=cat(1,R2Put2,R2Put6,R2Put7,R2Put10,R2Put11);
% COEFPutRed=cat(1,COEFPut2,COEFPut6,COEFPut7,COEFPut10,COEFPut11);
% 
% set (0,'DefaultFigureVisible','off');
% 
% for i=1:12
% R2Red=R2PutRed(:,i);
% R2Green=R2PutGreen(:,i);
% [pR2(i),tbR2(:,:,i),~]=anova1([R2Red, R2Green]);
% end
% 
% for i=1:12
% COEFRed=COEFPutRed(:,i);
% COEFGreen=COEFPutGreen(:,i);
% [pCOEF(i),tbCOEF(:,:,i),~]=anova1([COEFRed, COEFGreen]);
% end
% 
% delete(get(0,'children'));
% set (0,'DefaultFigureVisible','on');
% 
% 
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