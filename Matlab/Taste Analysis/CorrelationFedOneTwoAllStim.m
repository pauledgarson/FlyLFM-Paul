%% Calculating correlation between ON and OFF Responses and plotting as matrix (for 2 Animals)

% % opens window to select and load multiple datasets
% [file,path]=uigetfile('*.mat','Select TSROImeanPeaks mat-file with 12 regions','MultiSelect','on','/home/paul/Desktop');
% data=strcat(path,file)
% 
% for j=1:size(data,2)
% load(data{j})
% end

regionslist={'OL';'CX';'LX';'LH';'PENP';'INP';'VMNP';'MB';'AL';'SNP';'VLNP';'GNG'};

% Form all data into array and calculating peak responses
StimResponses_Fed=cat(4,StimResponses150,StimResponses151,StimResponses152,StimResponses153,StimResponses160,StimResponses161,StimResponses162,StimResponses163);

OnSucFed=reshape(StimResponses_Fed(:,:,1,:),[30,12,8]);
OffSucFed=reshape(StimResponses_Fed(:,:,2,:),[30,12,8]);
OnWatFed=reshape(StimResponses_Fed(:,:,3,:),[30,12,8]);
OffWatFed=reshape(StimResponses_Fed(:,:,4,:),[30,12,8]);
OnQuiFed=reshape(StimResponses_Fed(:,:,5,:),[30,12,8]);
OffQuiFed=reshape(StimResponses_Fed(:,:,6,:),[30,12,8]);

PeakONsucFed=max(OnSucFed,[],1)-mean(OnSucFed([1:9],:,:));
PeakOFFsucFed=max(OffSucFed,[],1)-mean(OffSucFed([1:9],:,:));

PeakONwatFed=max(OnWatFed,[],1)-mean(OnWatFed([1:9],:,:));
PeakOFFwatFed=max(OffWatFed,[],1)-mean(OffWatFed([1:9],:,:));

PeakONquiFed=max(OnQuiFed,[],1)-mean(OnQuiFed([1:9],:,:));
PeakOFFquiFed=max(OffQuiFed,[],1)-mean(OffQuiFed([1:9],:,:));

% Form array containing Peak ON/OFF responses for Suc and Qui 
PeakSucQui=cat(3,reshape(PeakONsucFed,[12,8]),reshape(PeakOFFsucFed,[12,8]),reshape(PeakONquiFed,[12,8]),reshape(PeakOFFquiFed,[12,8]));

% Extracting data for regions of interest
PeakSucQuiGNG=reshape(PeakSucQui(find(ismember(regionslist,'GNG')),:,:),[8,4]);
PeakSucQuiPENP=reshape(PeakSucQui(find(ismember(regionslist,'PENP')),:,:),[8,4]);
PeakSucQuiMB=reshape(PeakSucQui(find(ismember(regionslist,'MB')),:,:),[8,4]);
PeakSucQuiLH=reshape(PeakSucQui(find(ismember(regionslist,'LH')),:,:),[8,4]);

% Calculating correlation and p-vaulues for 1st and 2nd Trial
[RsucGNG,PsucGNG]=corr(PeakSucQuiGNG([1,2,5,6],:));
[RsucPENP,PsucPENP]=corr(PeakSucQuiPENP([1,2,5,6],:));
[RsucMB,PsucMB]=corr(PeakSucQuiMB([1,2,5,6],:));
[RsucLH,PsucLH]=corr(PeakSucQuiLH([1,2,5,6],:));

% Thresholding p-values to 0.05 and plottin as matrix
PsucGNG(PsucGNG>0.05)=0.06;
PsucPENP(PsucPENP>0.05)=0.06;
PsucMB(PsucMB>0.05)=0.06;
PsucLH(PsucLH>0.05)=0.06;


Stims={'Suc On','Suc Off','Qui On','Qui Off'};

f1=figure;

subplot(1,2,1);
imagesc(RsucGNG); % plot the matrix
set(gca, 'XTick', 1:4); % center x-axis ticks on bins
set(gca, 'YTick', 1:4); % center y-axis ticks on bins
set(gca, 'XTickLabel', Stims,'FontSize', 12); % set x-axis labels
set(gca, 'YTickLabel', Stims,'FontSize', 12); % set y-axis labels
title('Correlation of GNG ON/OFF', 'FontSize', 14); % set title
colormap('gray'); % set the colorscheme
colorbar;

subplot(1,2,2);
imagesc(PsucGNG); % plot the matrix
set(gca, 'XTick', 1:4); % center x-axis ticks on bins
set(gca, 'YTick', 1:4); % center y-axis ticks on bins
set(gca, 'XTickLabel', Stims,'FontSize', 12); % set x-axis labels
set(gca, 'YTickLabel', Stims,'FontSize', 12); % set y-axis labels
title('P-Values of GNG ON/OFF', 'FontSize', 14); % set title
colormap('gray'); % set the colorscheme
colorbar;


f2=figure;

subplot(1,2,1);
imagesc(RsucPENP); % plot the matrix
set(gca, 'XTick', 1:4); % center x-axis ticks on bins
set(gca, 'YTick', 1:4); % center y-axis ticks on bins
set(gca, 'XTickLabel', Stims,'FontSize', 12); % set x-axis labels
set(gca, 'YTickLabel', Stims,'FontSize', 12); % set y-axis labels
title('Correlation of PENP ON/OFF', 'FontSize', 14); % set title
colormap('gray'); % set the colorscheme
colorbar;

subplot(1,2,2);
imagesc(PsucPENP); % plot the matrix
set(gca, 'XTick', 1:4); % center x-axis ticks on bins
set(gca, 'YTick', 1:4); % center y-axis ticks on bins
set(gca, 'XTickLabel', Stims,'FontSize', 12); % set x-axis labels
set(gca, 'YTickLabel', Stims,'FontSize', 12); % set y-axis labels
title('P-Values of PENP ON/OFF', 'FontSize', 14); % set title
colormap('gray'); % set the colorscheme
colorbar;


f3=figure;

subplot(1,2,1);
imagesc(RsucMB); % plot the matrix
set(gca, 'XTick', 1:4); % center x-axis ticks on bins
set(gca, 'YTick', 1:4); % center y-axis ticks on bins
set(gca, 'XTickLabel', Stims,'FontSize', 12); % set x-axis labels
set(gca, 'YTickLabel', Stims,'FontSize', 12); % set y-axis labels
title('Correlation of MB ON/OFF', 'FontSize', 14); % set title
colormap('gray'); % set the colorscheme
colorbar;

subplot(1,2,2);
imagesc(PsucMB); % plot the matrix
set(gca, 'XTick', 1:4); % center x-axis ticks on bins
set(gca, 'YTick', 1:4); % center y-axis ticks on bins
set(gca, 'XTickLabel', Stims,'FontSize', 12); % set x-axis labels
set(gca, 'YTickLabel', Stims,'FontSize', 12); % set y-axis labels
title('P-Values of MB ON/OFF', 'FontSize', 14); % set title
colormap('gray'); % set the colorscheme
colorbar;

f4=figure;

subplot(1,2,1);
imagesc(RsucLH); % plot the matrix
set(gca, 'XTick', 1:4); % center x-axis ticks on bins
set(gca, 'YTick', 1:4); % center y-axis ticks on bins
set(gca, 'XTickLabel', Stims,'FontSize', 12); % set x-axis labels
set(gca, 'YTickLabel', Stims,'FontSize', 12); % set y-axis labels
title('Correlation of LH ON/OFF', 'FontSize', 14); % set title
colormap('gray'); % set the colorscheme
colorbar;

subplot(1,2,2);
imagesc(PsucLH); % plot the matrix
set(gca, 'XTick', 1:4); % center x-axis ticks on bins
set(gca, 'YTick', 1:4); % center y-axis ticks on bins
set(gca, 'XTickLabel', Stims,'FontSize', 12); % set x-axis labels
set(gca, 'YTickLabel', Stims,'FontSize', 12); % set y-axis labels
title('P-Values of LH ON/OFF', 'FontSize', 14); % set title
colormap('gray'); % set the colorscheme
colorbar;

