function [ fitness,z,Pre_Labels,test_Newtar] = feature_selection_new( select,data_a,data_b )
%% UNTITLED Summary of this function goes here
% Detailed explanation goes here
% select refers to pop(i).position
len = length(select);

%extracting reference and citer from position
num_ref = select(len-1);
num_citer = select(len);

train_bags = data_a;
train_target = data_b;

z = zeros(10,4);
[row,col] = size(train_bags);
select_binary = select(1:(len-2));
features = find(select_binary == 1);
p = 1;
q = 1;
for j = 1:length(features)
    for i = 1:row
        train_cvf{i}(:,q)=train_bags{i}(:,features(p));
    end
    p = p + 1;
    q = q + 1;
end

%Transposing train_cvf
train_cvf = train_cvf';


Index=randperm(row);
pixelrpt_ModBg  = cell(row,1);
for i=1:row
    pp=Index(i);
    pixelrpt_ModBg{i,1}=train_cvf{pp,1};
end
[row1,col1] = size(train_target);
pixelrpt_tarMod=zeros(row1,col1);
for i=1:col1
    pp=Index(i);
    pixelrpt_tarMod(:,i)=train_target(:,pp);
end

sub = round(row/10);
for k = 1:10
    p = 1;
    train1_NewBags = cell(((k-1)*sub),1);
    for i=1:(sub*(k-1))
        train1_NewBags{p,1}=pixelrpt_ModBg{i,1};
        p = p+1;
    end
    p = 1;
    train2_NewBags = cell((row-sub)-((k-1)*sub),1);
    for i=((sub*k)+1):row
        train2_NewBags{p,1}=pixelrpt_ModBg{i,1};
        p = p+1;
    end
    if(k == 1)
        train_NewBags = train2_NewBags;
    elseif(k == 10)
        train_NewBags = train1_NewBags;
    else
        train_NewBags = cat(1,train1_NewBags,train2_NewBags);
    end
    
    test_NewBags=cell(sub,1);
    p = 1;
    for i=(sub*(k-1)+1):(sub*k)
        test_NewBags{p,1}=pixelrpt_ModBg{i,1};
        p = p+1;
    end
    
    q = 1;
    train1_Newtar = zeros(row1,((k-1)*sub));
    for i=1:(sub*(k-1))
        train1_Newtar(:,q)=pixelrpt_tarMod(:,i);
        q = q+1;
    end
    q = 1;
    train2_Newtar = zeros(row1,(col1-sub)-((k-1)*sub));
    for i=((sub*k)+1):col1
        train2_Newtar(:,q)=pixelrpt_tarMod(:,i);
        q = q+1;
    end
    
    if(k == 1)
        train_Newtar = train2_Newtar;
    elseif(k == 10)
        train_Newtar = train1_Newtar;
    else
        train_Newtar = [train1_Newtar train2_Newtar];
    end
    test_Newtar=zeros(row1,sub);
    q = 1;
    for i=(sub*(k-1)+1):(sub*k)
        test_Newtar(:,q)=pixelrpt_tarMod(:,i);
        q = q+1;
    end
    
    [Weights,tr_time]=MIML_kNN_train(train_NewBags,train_Newtar,num_ref,num_citer);
    [HammingLoss,RankingLoss,OneError,Coverage,Average_Precision,Outputs,Pre_Labels,te_time]=MIML_kNN_test(train_NewBags,train_Newtar,test_NewBags,test_Newtar,num_ref,num_citer,Weights);
    z(k,1)=HammingLoss;
    z(k,2)=RankingLoss;
    z(k,3)=OneError;
  % z(k,4)=Coverage;
    z(k,4)=Average_Precision;
end
z_avg = mean(z);
for zz = 1:3
    if(z_avg(zz)==0)
        z_avg(zz) = 0.0000001;
    end
end
fitness = (0.25/z_avg(1))+(0.25/z_avg(2))+(0.25/z_avg(3))+(0.25*z_avg(4));

end