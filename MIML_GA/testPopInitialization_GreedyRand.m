nPop = 20;
nVar = 32;
nSel = 10;
VarMin = 0;
VarMax = 1;

empty_individual.Position=[];
% empty_individual.Cost=[];
% empty_individual.z=[];

pop=repmat(empty_individual,nPop,1);

    for i=1:nPop    
        % Initialize Position
        %pop(i).Position = randi([VarMin VarMax],1,nVar);
        
        %Implementation of the new Approach
        [pop(i).Position] = GreedyRand(VarMin,VarMax,nVar,nSel);
        
        
        r = randi([1 10],1,1);          % reference 1 to 10
        c = randi([1 20],1,1);          % citer 1 to 20
        %reference and citer added at the end of pop(i).position
        pop(i).Position = [pop(i).Position r c];
        
    end