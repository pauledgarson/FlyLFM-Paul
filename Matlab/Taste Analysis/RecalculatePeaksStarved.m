
% % opens window to select and load multiple datasets
% [file,path]=uigetfile('*.mat','Select TSROImeanPeaks mat-file with 12 regions','MultiSelect','on','/home/paul/Desktop');
% data=strcat(path,file)
% 
% for j=1:size(data,2)
% load(data{j})
% end

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

StimPeaks_Starved=cat(1,PeakONsucSta,PeakOFFsucSta,PeakONwatSta,PeakOFFwatSta,PeakONquiSta,PeakOFFquiSta);