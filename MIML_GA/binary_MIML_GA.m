clc;
clear;
close all;
%rng(seed)
%rng(seed) specifies the seed for MATLAB random number generator.
%rng function controls the global stream,which determines how the rand,
%randi, randn and randperm funtions produce a sequence of random numbers.
for cn=1             
 rng(cn);
%% Problem Definition


nVar=32;                        % Number of features
VarSize=[1 nVar];               % Decision Variables Matrix Size

%if 1 then feature is selected , if 0 then feature is not selected
VarMin= 0;                      % Lower Bound of Variables
VarMax= 1;                      % Upper Bound of Variables

%% Import Data

data = load('sample_newdata.mat');
data_a = data.train_bags;
data_b = data.train_target;

%% Genetic Algorithm Parameters

MaxIt=1;                       % Maximum Number of Iterations
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

empty_individual.Position=[];
empty_individual.Cost=[];
empty_individual.z=[];

pop=repmat(empty_individual,nPop,1);

    for i=1:nPop    
        % Initialize Position
        %Method 1: Purely Random
        %pop(i).Position = randi([VarMin VarMax],1,nVar);
        
        %Method 2: Purely Heuristic
        pop(i).Position = randi([0 0],1,nVar);
        k=i;
        for j=1:nSel
            k = rem(k,nVar);
            if k==0
                k=nVar;
            end
            pop(i).Position(k) = 1;
            k = k+1;
        end

        %Method 3: Hybrid Model
        %[pop(i).Position] = GreedyRand(VarMin,VarMax,nVar,nSel);
        
        r = randi([1 10],1,1);          % reference 1 to 10
        c = randi([1 20],1,1);          % citer 1 to 20
        %reference and citer added at the end of pop(i).position
        pop(i).Position = [pop(i).Position r c];
        
        % Evaluation
        % call MIML to calculate cost
        [pop(i).Cost,pop(i).z]=feature_selection3( pop(i).Position,data_a,data_b );
    end


% Sort Population
Costs=[pop.Cost];
[Costs, SortOrder]=sort(Costs,'descend');
pop=pop(SortOrder);

% Store Best Solution
BestSol=pop(1);

% Array to Hold Best Cost Values
BestCost=zeros(MaxIt,1);

% Store Cost
WorstCost=pop(end).Cost;


%% Main Loop (Evolution Loop)

    for it=1:MaxIt
        % P stores cost/(sum of all cost) for every people
        P = Costs/sum(Costs);
        
        % Elitism
        pop_e=repmat(empty_individual,ne,1);
        for i = 1:ne
            pop_e(i) = pop(i);
        end
        
        % Crossover
        popc=repmat(empty_individual,nc/2,2);
        for k=1:nc/2
            % Select Parents Indices
            % Roulette Wheel Selection
            i1=Roulette_WheelSelection(P);
            i2=Roulette_WheelSelection(P);
            p1=pop(i1);
            p2=pop(i2);
            
            % Applying Single Point Crossover
            [popc(k,1).Position, popc(k,2).Position]=SinglePointCrossover(p1.Position,p2.Position);
            
            % Evaluate Offsprings
            [popc(k,1).Cost,popc(k,1).z]=feature_selection3(popc(k,1).Position,data_a,data_b);
            [popc(k,2).Cost,popc(k,2).z]=feature_selection3(popc(k,2).Position,data_a,data_b);
            
        end
        
        popc=popc(:);
        
        % Mutation
        popm=repmat(empty_individual,nm,1);
        
        for k=1:nm
            
            % Select Parent
            i=randi([1 nPop]);
            p=pop(i);
            
            % Apply Mutation
            popm(k).Position=Mutate(p.Position,mu);
            
            % Evaluate Mutant
            [popm(k).Cost,popm(k).z]=feature_selection3(popm(k).Position,data_a,data_b);
            
        end
        
        % Create Merged Population
        pop=[pop_e
            popc
            popm];
        
        % Sort Population
        Costs=[pop.Cost];
        [Costs, SortOrder]=sort(Costs,'descend');
        pop=pop(SortOrder);
        
        % Update Worst Cost
        WorstCost=max(WorstCost,pop(end).Cost);
        
        % Truncation
        pop=pop(1:nPop);
        Costs=Costs(1:nPop);
        
        % Store Best Solution Ever Found
        BestSol=pop(1);
        
        % Store Best Cost Ever Found
        BestCost(it)=BestSol.Cost;
        
        % Show Iteration Information
        disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCost(it)) BestSol.z] );
        disp(BestSol.z)
    end
end
