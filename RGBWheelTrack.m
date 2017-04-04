function [cen,noOfMarks] = RGBWheelTrack(im,mgin,n)
cen=0;
noOfMarks=0;
[width, height, ~]= size(im);
result=zeros(width,height);
i=mgin+1:width-mgin-1;
j=mgin+1:height-mgin-1;
tic
result(i,j)=((im(i,j-mgin,1)>im(i+mgin/2,j-mgin/2,1)) & (im(i,j-mgin,1)>im(i+mgin/2,j+mgin/2,1))    &     (im(i+mgin/2,j-mgin/2,3)>im(i,j-mgin,3)) & (im(i+mgin/2,j-mgin/2,3)>im(i+mgin/2,j+mgin/2,3))    &    (im(i+mgin/2,j+mgin/2,2)>im(i,j-mgin,2)) & (im(i+mgin/2,j+mgin/2,2)>im(i+mgin/2,j-mgin/2,2)));
toc
%result(i,j)=1;
tic
%result=imdilate(imfill(imopen(result,strel('disk',1)),'holes'),strel('disk',5));
%erode then dilate big then imfill
%result=imfill(imdilate(imerode(result,strel('disk',1)),strel('disk',10)),'holes');
result=(imdilate(imerode(result,strel('disk',1)),strel('disk',10)));
%result=imdilate(result,strel('disk',8));
toc
imshow(imfuse(result,im));
s=regionprops(bwlabel(result),'Centroid','Area');
[~, ind]=sort([s.Area],'descend');
s=s(ind);
%s.Area
[n,~]=size(s);
cen=zeros(n);
if (isempty(s)==0)
    cen=s(1);
    noOfMarks=n;
    for i=2:size(s)
        cen=[cen s(i)];
    end
end
end
%sort according to i coordinate
