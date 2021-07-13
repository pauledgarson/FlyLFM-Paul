% Calculating correlation between ON and OFF Responses and plotting as
% matrix (for 2 animals)

% %opens window to select and load multiple datasets
% [file,path]=uigetfile('*.mat','Select TSROImeanPeaks mat-file with 12 regions','MultiSelect','on','/home/paul/Desktop');
% data=strcat(path,file)
% 
% for j=1:size(data,2)
% load(data{j})
% end

regionslist={'OL';'CX';'LX';'LH';'PENP';'INP';'VMNP';'MB';'AL';'SNP';'VLNP';'GNG'};

% Form all data into array and calculating peak responses
StimResponses_Starved=cat(4,StimResponses142,StimResponses143,StimResponses144,StimResponses145,StimResponses154,StimResponses155,StimResponses156,StimResponses157);

OnSucSta=reshape(StimResponses_Starved(:,:,1,:),[30,12,8]);
OffSucSta=reshape(StimResponses_Starved(:,:,2,:),[30,12,8]);
OnWatSta=reshape(StimResponses_Starved(:,:,3,:),[30,12,8]);
OffWatSta=reshape(StimResponses_Starved(:,:,4,:),[30,12,8]);
OnQuiSta=reshape(StimResponses_Starved(:,:,5,:),[30,12,8]);
OffQuiSta=reshape(StimResponses_Starved(:,:,6,:),[30,12,8]);

PeakONsucSta=max(OnSucSta,[],1)-mean(OnSucSta([1:9],:,:));
PeakOFFsucSta=max(OffSucSta,[],1)-mean(OffSucSta([1:9],:,:));

PeakONwatSta=max(OnWatSta,[],1)-mean(OnWatSta([1:9],:,:));
PeakOFFwatSta=max(OffWatSta,[],1)-mean(OffWatSta([1:9],:,:));

PeakONquiSta=max(OnQuiSta,[],1)-mean(OnQuiSta([1:9],:,:));
PeakOFFquiSta=max(OffQuiSta,[],1)-mean(OffQuiSta([1:9],:,:));


% Form array containing Peak ON/OFF responses for Suc and Qui 
PeakSucQui=cat(3,reshape(PeakONsucSta,[12,8]),reshape(PeakOFFsucSta,[12,8]),reshape(PeakONquiSta,[12,8]),reshape(PeakOFFquiSta,[12,8]));

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
