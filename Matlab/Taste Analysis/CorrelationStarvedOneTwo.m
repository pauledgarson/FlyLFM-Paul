% Calculating correlation between ON and OFF Responses and plotting as matrix

%opens window to select and load multiple datasets
[file,path]=uigetfile('*.mat','Select TSROImeanPeaks mat-file with 12 regions','MultiSelect','on','/home/paul/Desktop');
data=strcat(path,file)

for j=1:size(data,2)
load(data{j})
end

% Form all data into array and calculating peak responses
StimResponses_Starved=cat(4,StimResponses134,StimResponses135,StimResponses136,StimResponses137,StimResponses142,StimResponses143,StimResponses144,StimResponses145,StimResponses154,StimResponses155,StimResponses156,StimResponses157);

OnSucSta=reshape(StimResponses_Starved(:,:,1,:),[30,12,12]);
OffSucSta=reshape(StimResponses_Starved(:,:,2,:),[30,12,12]);
OnWatSta=reshape(StimResponses_Starved(:,:,3,:),[30,12,12]);
OffWatSta=reshape(StimResponses_Starved(:,:,4,:),[30,12,12]);
OnQuiSta=reshape(StimResponses_Starved(:,:,5,:),[30,12,12]);
OffQuiSta=reshape(StimResponses_Starved(:,:,6,:),[30,12,12]);

PeakONsucSta=max(OnSucSta,[],1)-mean(OnSucSta([1:9],:,:));
PeakOFFsucSta=max(OffSucSta,[],1)-mean(OffSucSta([1:9],:,:));

PeakONwatSta=max(OnWatSta,[],1)-mean(OnWatSta([1:9],:,:));
PeakOFFwatSta=max(OffWatSta,[],1)-mean(OffWatSta([1:9],:,:));

PeakONquiSta=max(OnQuiSta,[],1)-mean(OnQuiSta([1:9],:,:));
PeakOFFquiSta=max(OffQuiSta,[],1)-mean(OffQuiSta([1:9],:,:));


%creating array with only Sucrose and Quinine stimulations 
PeakSucQui=cat(1,PeakONsucSta,PeakOFFsucSta,PeakONquiSta, PeakOFFquiSta); %Array structure: Stimulus x Regions x Trials
%Averaging peak responses over trials and transpose to 12x4 matrix
AvgPeakSucQui=mean(PeakSucQui,3)';

%Calculating correlation and p-values
[R,P]=corr(AvgPeakSucQui); 

stimulus={'SucOn','SucOff','QuiOn','QuiOff'};

f1=figure;

imagesc(R); % plot the matrix
set(gca, 'XTick', 1:4); % center x-axis ticks on bins
set(gca, 'YTick', 1:4); % center y-axis ticks on bins
set(gca, 'XTickLabel', stimulus,'FontSize', 12); % set x-axis labels
set(gca, 'YTickLabel', stimulus,'FontSize', 12); % set y-axis labels
title('Correlation of Peak ON/OFF (Starved)', 'FontSize', 14); % set title
colormap('autumn'); % set the colorscheme
colorbar;

% Thresholding p-values to 0.06 and plottin as matrix
P(P>0.05)=0.06;

f2=figure;

imagesc(P); % plot the matrix
set(gca, 'XTick', 1:4); % center x-axis ticks on bins
set(gca, 'YTick', 1:4); % center y-axis ticks on bins
set(gca, 'XTickLabel', stimulus,'FontSize', 12); % set x-axis labels
set(gca, 'YTickLabel', stimulus,'FontSize', 12); % set y-axis labels
title('P-Values of Peak ON/OFF (Starved)', 'FontSize', 14); % set title
colormap('gray'); % set the colorscheme
colorbar;

% regionslist={'OL';'CX';'LX';'LH';'PENP';'INP';'VMNP';'MB';'AL';'SNP';'VLNP';'GNG'};
% 
% % Calculating correlation for 1st and 2nd Trial
% [Rsuc,Psuc]=corr(reshape(PeakONsucSta(1,:,[5,6,9,10]),[4,12]),reshape(PeakOFFsucSta(1,:,[5,6,9,10]),[4,12]));
% [Rqui,Pqui]=corr(reshape(PeakONquiSta(1,:,[5,6,9,10]),[4,12]),reshape(PeakOFFquiSta(1,:,[5,6,9,10]),[4,12]));
% 
% f1=figure;
% 
% imagesc(Rsuc); % plot the matrix
% set(gca, 'XTick', 1:12); % center x-axis ticks on bins
% set(gca, 'YTick', 1:12); % center y-axis ticks on bins
% set(gca, 'XTickLabel', regionslist,'FontSize', 12); % set x-axis labels
% set(gca, 'YTickLabel', regionslist,'FontSize', 12); % set y-axis labels
% title('Correlation of Suc ON/OFF', 'FontSize', 14); % set title
% colormap('autumn'); % set the colorscheme
% colorbar;
% 
% f2=figure;
% 
% imagesc(Rqui); % plot the matrix
% set(gca, 'XTick', 1:12); % center x-axis ticks on bins
% set(gca, 'YTick', 1:12); % center y-axis ticks on bins
% set(gca, 'XTickLabel', regionslist,'FontSize', 12); % set x-axis labels
% set(gca, 'YTickLabel', regionslist,'FontSize', 12); % set y-axis labels
% title('Correlation of Qui ON/OFF', 'FontSize', 14); % set title
% colormap('autumn'); % set the colorscheme
% colorbar;
% 
% % Thresholding p-values to 0.06 and plottin as matrix
% Psuc(Psuc>0.05)=0.06;
% Pqui(Pqui>0.05)=0.06;
% 
% f3=figure;
% 
% imagesc(Psuc); % plot the matrix
% set(gca, 'XTick', 1:12); % center x-axis ticks on bins
% set(gca, 'YTick', 1:12); % center y-axis ticks on bins
% set(gca, 'XTickLabel', regionslist,'FontSize', 12); % set x-axis labels
% set(gca, 'YTickLabel', regionslist,'FontSize', 12); % set y-axis labels
% title('P-Values of Suc ON/OFF', 'FontSize', 14); % set title
% colormap('gray'); % set the colorscheme
% colorbar;
% 
% f4=figure;
% 
% imagesc(Pqui); % plot the matrix
% set(gca, 'XTick', 1:12); % center x-axis ticks on bins
% set(gca, 'YTick', 1:12); % center y-axis ticks on bins
% set(gca, 'XTickLabel', regionslist,'FontSize', 12); % set x-axis labels
% set(gca, 'YTickLabel', regionslist,'FontSize', 12); % set y-axis labels
% title('P-Values of Qui ON/OFF', 'FontSize', 14); % set title
% colormap('gray'); % set the colorscheme
% colorbar;
