%% Extracting the response to Putrescine (100 frames before and 200 frames after stimulation) from TS averaged over both hemispheres

%opens window to select and load dataset
[file,path]=uigetfile('*.mat','Select TSROImean mat-file with 12 regions','/home/paul/Desktop');
data=strcat(path,file)
load(data)

FirstStim=1000;

SecStim=1500;

ThirdStim=2000;

FourStim=2500;


FirstResponse=Brain((FirstStim-100):(FirstStim+199),:);

SecResponse=Brain((SecStim-100):(SecStim+199),:);

ThirdResponse=Brain((ThirdStim-100):(ThirdStim+199),:);

FourResponse=Brain((FourStim-100):(FourStim+199),:);


StimResponsesPut310=cat(3,FirstResponse,SecResponse,ThirdResponse,FourResponse);



FirstPeak=max(FirstResponse,[],1)-mean(FirstResponse([1:50],:));

SecPeak=max(SecResponse,[],1)-mean(SecResponse([1:50],:));

ThirdPeak=max(ThirdResponse,[],1)-mean(ThirdResponse([1:50],:));

FourPeak=max(FourResponse,[],1)-mean(FourResponse([1:50],:));


StimPeaksPut310=[FirstPeak;SecPeak;ThirdPeak;FourPeak];


%saves variable as new mat file with matching name
save(strcat(data(1:size(data,2)-6),'Peaks12.mat'),'StimResponsesPut310','StimPeaksPut310');