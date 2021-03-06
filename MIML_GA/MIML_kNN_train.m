function [Weights,tr_time]=MIML_kNN_train(train_ModBg,train_tarMod,num_ref,num_citer)
%MIML_kNN_train trains a lazy multi-instance multi-label learner
%
%    Syntax
%
%       [Weights,tr_time]=MIML_kNN_train(train_bags,train_target,num_ref,num_citer)
%
%    Description
%
%       MIML_kNN_train takes,
%           train_bags    - An Mx1 cell, the ith training bag is stored in train_bags{i,1}
%           train_target  - A QxM array, if the ith training bag belongs to the jth class, then train_target(j,i) equals +1, otherwise train_target(j,i) equals -1
%           num_ref       - Number of references considered by MIML-kNN
%           num_citer     - Number of citers considered by MIML-kNN
%      and returns,
%           Weights      - A QxQ matrix used for label prediction
%           tr_time      - The time spent in training
   
    start_time=cputime;
    
    [num_class,num_train]=size(train_tarMod);
    
%     disp('Computing distance...');
    Dist=zeros(num_train,num_train);
    for i=1:(num_train-1)
        if(mod(i,10)==0)
%             disp(strcat(num2str(i),'/',num2str(num_train)));
        end
        for j=(i+1):num_train
            Dist(i,j)=GMIL_Hausdorff(train_ModBg{i,1},train_ModBg{j,1});
        end
    end
    Dist=Dist+Dist';
    
%     disp('Estimating parameters...');
    A=zeros(num_train,num_class);
    B=zeros(num_train,num_class);
    
    sorted_index=cell(num_train,1);%the neighbors for the i-th bag is stored in sorted_index{i,1} in from nearest to furtherest
    for i=1:num_train
        dist_row=Dist(i,:);
        dist_row(1,i)=-1;
        [sorted_dist_row,ref_index]=sort(dist_row,'ascend');
        sorted_index{i,1}=ref_index(2:num_train);
    end
    for i=1:num_train
        if(mod(i,100)==0)
%             disp(strcat(num2str(i),'/',num2str(num_train)));
        end        
        ref_index=sorted_index{i,1}(1:num_ref);
        citer_index=[];
        for j=1:num_train
            if(ismember(i,sorted_index{j,1}(1:num_citer)))
                citer_index=[citer_index,j];
            end
        end
        target=train_tarMod(:,[ref_index,citer_index]);
        count=sum((target==1),2);
        A(i,:)=count;        
        B(i,:)=train_tarMod(:,i);
    end
    s=rank(A);
    [r,c]=size(A);
%   disp(r);
%   disp(c);
%   disp(size(A));
%   disp(s);
   
    if(s < c)
       Weights=pinv(A)*B; 
        
    else
    Weights=A\B;
    end
    tr_time=cputime-start_time;