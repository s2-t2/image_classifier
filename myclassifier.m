function S = myclassifier(im)
%clear;
%close all;
%
%This baseline classifier tries to guess... so should score about (3^3)^-1
%on average, approx. a 4% chance of guessing the correct answer. 

I = im;

%imshow(I);
thres = graythresh(I);
bin = imbinarize(I);
%figure(1);
%imshowpair(I,bin,'montage');
Idist=bwdist(I,'cityblock');
Inew = medfilt2(Idist);
% figure(2);
%imshowpair(I,Inew,'montage');
bwm = bwmorph(Inew,'skel',Inf);
%figure(3);
%imshowpair(I,bwm, 'montage');

%connected components
CC = bwconncomp(bwm);
boundbox =regionprops(CC, 'BoundingBox');

counter1 = 0;
counter2 = 0;
counter3 = 0;

if CC.NumObjects >= 3 
    %component1 midpoints
    mpX = ceil((boundbox(1).BoundingBox(1) + (boundbox(1).BoundingBox(1) + boundbox(1).BoundingBox(3)))/2);
    UmpY = ceil(boundbox(1).BoundingBox(2));
    DmpY = ceil(boundbox(1).BoundingBox(2) + boundbox(1).BoundingBox(4));
    
    for i=UmpY-1:DmpY
        if bwm(1+i, mpX) == 1
            counter1 = counter1 + 1;
        end;
    end;
            
    %component2 midpoints
    mpX2 = ceil((boundbox(2).BoundingBox(1) + (boundbox(2).BoundingBox(1) + boundbox(2).BoundingBox(3)))/2);
    UmpY2 = ceil(boundbox(2).BoundingBox(2));
    DmpY2 = ceil(boundbox(2).BoundingBox(2) + boundbox(2).BoundingBox(4));
    
    for j=UmpY2-1:DmpY2
        if bwm(1+j,mpX2) == 1
            counter2 = counter2 + 1;
        end;
    end;

    %component3 midpoints
    mpX3 = ceil((boundbox(3).BoundingBox(1) + (boundbox(3).BoundingBox(1) + boundbox(3).BoundingBox(3)))/2);
    UmpY3 = ceil(boundbox(3).BoundingBox(2));
    DmpY3 = ceil(boundbox(3).BoundingBox(2) + boundbox(3).BoundingBox(4));
    
    for k=UmpY3-1:DmpY3
        if bwm(1+k,mpX3) == 1
            counter3 = counter3 + 1;
        end;
    end;
end;

S = [];
if counter1 == 1 
    S1 = 1;
elseif counter1 == 2
    S1 = 0;
else 
    S1 = 2;
end;

if counter2 == 1 
    S2 = 1;
elseif counter2 == 2
    S2 = 0;
else 
    S2 = 2;
end;

if counter3 == 1 
    S3 = 1;
elseif counter3 == 2
    S3 = 0;
else 
    S3 = 2;
end;

S = [S1, S2, S3];

end

