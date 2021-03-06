
function distance=GMIL_Hausdorff(Bag1,Bag2)
% maxHausdorff  Compute the maximum Hausdorff distance between two bags Bag1 and Bag2
% maxHausdorff takes,
%   Bag1 - one bag of instances
%   Bag2 - the other bag of instances
%   and returns,
%   distance - the maximum Hausdorff distance between Bag1 and Bag2

    size1=size(Bag1);
    size2=size(Bag2);
    line_num1=size1(1);
    line_num2=size2(1);
    dist=zeros(line_num1,line_num2);
    for i=1:line_num1
        for j=1:line_num2
            dist(i,j)=sqrt(sum((Bag1(i,:)-Bag2(j,:)).^2));
        end
    end
    distance=(sum(min(dist))+sum(min(dist')))/(line_num1+line_num2);

%     count=0;
%     for i=1:line_num1
%         for j=1:line_num2
%             count=count+(dist(i,j)==0);
%         end
%     end
%     if(count==0)
%         distance=1.2;
%     else
%         distance=1/count;
%     end