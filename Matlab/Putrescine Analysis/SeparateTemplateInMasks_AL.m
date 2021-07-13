clear all
[FileName,PathName] = uigetfile('*.nii','Select the registered template file','/home/paul/Desktop/');
file=strcat(PathName,FileName)
D=MRIread(file);
Masks=D.vol;
Sm=size(Masks);


Masks2=zeros(Sm(1),Sm(2),Sm(3),188);

parfor j=1:188
    Masks2(:,:,:,j)=(Masks==j);
    j
end

VA2=Masks2(:,:,:,162);
VM2=Masks2(:,:,:,188);
DM2=Masks2(:,:,:,46);
DM1=Masks2(:,:,:,40);
DM4=Masks2(:,:,:,79);
VC5=Masks2(:,:,:,64);
DP1m=Masks2(:,:,:,108);

Masks3=cat(4,VA2,VM2,DM2,DM1,DM4,VC5,DP1m);

out.vol=Masks3;
err = MRIwrite(out,strcat(file(1:size(file,2)-4),'separate.nii'));