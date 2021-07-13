clear all
[FileName,PathName] = uigetfile('*.nii','Select the registered template file','/home/paul/Desktop/');
file=strcat(PathName,FileName)
D=MRIread(file);
Masks=D.vol;
Sm=size(Masks);


Masks2=zeros(Sm(1),Sm(2),Sm(3),255);

parfor j=1:255
    Masks2(:,:,:,j)=(Masks==j);
    j
end

LH_AL=Masks2(:,:,:,139);
LH_AM=Masks2(:,:,:,172);
LH_PM=Masks2(:,:,:,255);


Masks3=cat(4,LH_AL,LH_AM,LH_PM);

out.vol=Masks3;
err = MRIwrite(out,strcat(file(1:size(file,2)-4),'separate.nii'));