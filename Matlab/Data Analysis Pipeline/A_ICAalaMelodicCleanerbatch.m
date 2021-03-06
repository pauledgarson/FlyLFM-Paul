% This script performs PCA and spatial ICA with a normalization similar to melodic from FSL 

clear all

% Prompt window to select target data file. Read in data file. Choose
%data with movement PC subtracted
[FileName,PathName] = uigetfile('*.nii','Select the Nifti file','MultiSelect','on');
files=strcat(PathName,FileName)

for j=1:size(files,2)
clear D data S Data2 out R Dica GMo DE Dpca;
file=files{j};    
B=MRIread(files{j});
D=double(B.vol); 
clear B

% Reshape as a space*time 2D matrix 
S1=size(D);
parfor i=1:S1(4)
R(i,:)=reshape(D(:,:,:,i),[1,S1(1)*S1(2)*S1(3)]);
end
clear D
R0=R;

% Demean
S2=size(R);
parfor i=1:S2(2)
    Rm(i)=mean(R(:,i));
    R(:,i)=R(:,i)-Rm(i);
end

P=prctile(reshape(R,size(R,1)*size(R,2),1),90);
R1=R.*(10000/P);
clear R

R=R1;

%% Simple std norm (choose between this and Smith lines below)
%   stddevs=max(std(R),0.01);  
%   R=R./repmat(stddevs,size(R,1),1);  % var-norm

%% Variance normalisation ala melodic
% Check dimentionality
[u,s,v]=nets_svds(R,1000); 
plot(log(diag(s)))
% Choose NPCfilt at the elbow (empirically found that allows to get most
% activity related components without too many noise components
Spectrum=log(diag(s));
Diffvalue=-(max(Spectrum)-min(Spectrum))/1000;
DiffFunc=smooth(diff(smooth(Spectrum,20)));
NPCfilt=find(DiffFunc>Diffvalue, 1 )

uu=u(:,1:NPCfilt);
vv=v(:,1:NPCfilt);
ss=s(1:NPCfilt,1:NPCfilt);

vv(abs(vv)<0.4*std(vv(:)))=0;
%vv(abs(vv)<2.3*std(vv(:)))=0;
%vv(abs(vv)<0.023*std(vv(:)))=0;
stddevs=max(std(R-uu*ss*vv'),1);  
% Subtract main parts of tcop components from data to get normalisation
% Which leaves most main components not normalized
% Note also that small values are not increased (normalized by one)
R=R./repmat(stddevs,size(R,1),1);  % Var-norm



[u,s,v]=nets_svds(R,1000); 
plot(log(diag(s)))
% Choose NPCfilt at 2*the elbow (empirically found that allows to get most
% activity related components without too many noise components
Spectrum=log(diag(s));
Diffvalue=-(max(Spectrum)-min(Spectrum))/1000;
DiffFunc=smooth(diff(smooth(Spectrum,20)));
Npc=2*find(DiffFunc>Diffvalue, 1 )

%% SVD
[u,s,v]=nets_svds(R,Npc);

% Save PCA maps
DE=s*v';
for i=1:Npc
Dpca(:,:,:,i)=reshape(DE(i,:),[S1(1),S1(2),S1(3)]);
end
out4.vol = Dpca;
err = MRIwrite(out4,strcat(file(1:size(file,2)-4),'PCAMaps.nii'));

save(strcat(file(1:size(file,2)-4),'PCATS'),'u')


%% ICA
[icasig, A, W] = fastica (v','approach','symm','epsilon', 0.001);


%% Correct sign so that mean of the positive side is larger than the mean of
% the negative side after zscoring
% form back ica maps

GM=icasig';
GMv=GM./repmat(std(GM),size(GM,1),1);
GMzp=GMv-2;
GMzp(GMzp<0)=0;
GMzpm=mean(GMzp);
GMzn=GMv+2;
GMzn(GMzn>0)=0;
GMznm=mean(GMzn);
GMs=GM.*repmat(sign(GMzpm+GMznm),size(GM,1),1); 

TS=u*s*A;
TSs=TS.*repmat(sign(GMzpm+GMznm),size(TS,1),1);

%reorder maps by variance 
[varo,Order]=sort(var(TS));
%plot(varo)
TSo=TSs(:,Order(Npc:-1:1));
GMo=GMs(:,Order(Npc:-1:1));

SG=size(GMo);

% Reform volumes
for i=1:SG(2)
Dica(:,:,:,i)=reshape(GMo(:,i),[S1(1),S1(2),S1(3)]);
end

% Save ICA maps and time series
out.vol = Dica;
err = MRIwrite(out,strcat(file(1:size(file,2)-4),num2str(Npc),'Smith20_4_',num2str(NPCfilt),'IC.nii'));

save(strcat(file(1:size(file,2)-4),num2str(Npc),'Smith20_4_',num2str(NPCfilt),'TS'),'TSo')


% Next step is opening the maps and time series in an ipython notebook for
% manual sorting
end
