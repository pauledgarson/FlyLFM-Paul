% %% Calculating correlation between ON and OFF Responses and plotting as matrix
% 
% %opens window to select and load multiple datasets
% [file,path]=uigetfile('*.mat','Select TSROImeanPeaks mat-file with 12 regions','MultiSelect','on','/home/paul/Desktop');
% data=strcat(path,file)
% 
% for j=1:size(data,2)
% load(data{j})
% end

% Form all data into array and calculating peak responses
StimResponses_Fed=cat(4,StimResponses146,StimResponses147,StimResponses148,StimResponses149,StimResponses150,StimResponses151,StimResponses152,StimResponses153,StimResponses160,StimResponses161,StimResponses162,StimResponses163);

OnSucFed=reshape(StimResponses_Fed(:,:,1,:),[30,12,12]);
OffSucFed=reshape(StimResponses_Fed(:,:,2,:),[30,12,12]);
OnWatFed=reshape(StimResponses_Fed(:,:,3,:),[30,12,12]);
OffWatFed=reshape(StimResponses_Fed(:,:,4,:),[30,12,12]);
OnQuiFed=reshape(StimResponses_Fed(:,:,5,:),[30,12,12]);
OffQuiFed=reshape(StimResponses_Fed(:,:,6,:),[30,12,12]);

PeakONsucFed=max(OnSucFed,[],1)-mean(OnSucFed([1:9],:,:));
PeakOFFsucFed=max(OffSucFed,[],1)-mean(OffSucFed([1:9],:,:));

PeakONwatFed=max(OnWatFed,[],1)-mean(OnWatFed([1:9],:,:));
PeakOFFwatFed=max(OffWatFed,[],1)-mean(OffWatFed([1:9],:,:));

PeakONquiFed=max(OnQuiFed,[],1)-mean(OnQuiFed([1:9],:,:));
PeakOFFquiFed=max(OffQuiFed,[],1)-mean(OffQuiFed([1:9],:,:));

%creating array with only Sucrose and Quinine stimulations 
PeakSucQui=cat(1,PeakONsucFed,PeakOFFsucFed,PeakONquiFed, PeakOFFquiFed); %Array structure: Stimulus x Regions x Trials
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
title('Correlation of Peak ON/OFF (Fed)', 'FontSize', 14); % set title
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
title('P-Values of Peak ON/OFF (Fed)', 'FontSize', 14); % set title
colormap('gray'); % set the colorscheme
colorbar;

% regionslist={'OL';'CX';'LX';'LH';'PENP';'INP';'VMNP';'MB';'AL';'SNP';'VLNP';'GNG'};

% % Calculating correlation and p-vaulues for 1st and 2nd Trial
% [Rsuc,Psuc]=corr(reshape(PeakONsucFed(1,:,[5,6,9,10]),[4,12]),reshape(PeakOFFsucFed(1,:,[5,6,9,10]),[4,12]));
% [Rqui,Pqui]=corr(reshape(PeakONquiFed(1,:,[5,6,9,10]),[4,12]),reshape(PeakOFFquiFed(1,:,[5,6,9,10]),[4,12]));
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


