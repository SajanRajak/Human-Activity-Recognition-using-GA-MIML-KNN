clc;
clear;
close all;
%rng(seed)
%rng(seed) specifies the seed for MATLAB random number generator.
%rng function controls the global stream,which determines how the rand,
%randi, randn and randperm funtions produce a sequence of random numbers.
for cn=5             
 rng(cn);
%% Problem Definition


nVar=32;                        % Number of features
VarSize=[1 nVar];               % Decision Variables Matrix Size

%if 1 then feature is selected , if 0 then feature is not selected
VarMin= 0;                      % Lower Bound of Variables
VarMax= 1;                      % Upper Bound of Variables

%% Import Data

data = load('TR2_dataset.mat');
train_bag = data.train_bag;
train_target = data.train_target;
test_bag = data.test_bag;
test_target = data.test_target;
%% Genetic Algorithm Parameters

MaxIt=1;                        % Maximum Number of Iterations
nPop=20;                        % Population Size
pc=0.7;                         % Crossover Percentage
nc=2*round(pc*nPop/2);          % Number of Offsprings (also Parnets)
gamma=0.4;                      % Extra Range Factor for Crossover
pe = 0.1;                       % Elite People rate
ne = round(pe*nPop);            % Number of Elite People
pm=0.3;                         % Mutation Percentage
nm=round(pm*nPop);              % Number of Mutants
mu=0.1;                         % Mutation Rate
nSel = 10;                      % Number of feature selected

pause(0.01); % Due to a bug in older versions of MATLAB

%% Initialization
load('new_Random_cn_5.mat','pop');
empty_individual.Position=[];
empty_individual.Cost=[];
empty_individual.z=[];

new_pop=repmat(empty_individual,nPop,1);

    for i=1:nPop   
        new_pop(i).Position = pop.Position;
        [new_pop(i).Cost,new_pop(i).z,new_pop(i).Predicted_Labels,new_pop(i).Actual_Test_Labels]=feature_selection_TR2( new_pop(i).Position,train_bag,train_target,test_bag,test_target);
    end
end
