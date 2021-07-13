
% % opens window to select and load multiple datasets
% [file,path]=uigetfile('*.mat','Select TSROImeanPeaks mat-file with 12 regions','MultiSelect','on','/home/paul/Desktop');
% data=strcat(path,file)
% 
% for j=1:size(data,2)
% load(data{j})
% end

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

StimPeaks_Fed=cat(1,PeakONsucFed,PeakOFFsucFed,PeakONwatFed,PeakOFFwatFed,PeakONquiFed,PeakOFFquiFed);