function [ fitness,z_avg,Pre_Labels,test_target ] = feature_selection_TR2( select,train_bag,train_target,test_bag,test_target)
%% UNTITLED Summary of this function goes here
% Detailed explanation goes here
% select refers to pop(i).position
len = length(select);

%extracting reference and citer from position
num_ref = select(len-1);
num_citer = select(len);

[Weights,tr_time]=MIML_kNN_train(train_bag,train_target,num_ref,num_citer);
[HammingLoss,RankingLoss,OneError,Coverage,Average_Precision,Outputs,Pre_Labels,te_time]=MIML_kNN_test(train_bag,train_target,test_bag,test_target,num_ref,num_citer,Weights);
z(1)=HammingLoss;
z(2)=RankingLoss;
z(3)=OneError;
% z(k,4)=Coverage;
z(4)=Average_Precision;
z_avg = z;
fitness = (0.25/z(1))+(0.25/z(2))+(0.25/z(3))+(0.25*z(4));

end