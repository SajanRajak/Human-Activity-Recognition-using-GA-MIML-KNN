nPop = 20;
nVar = 32;
nSel = 10;
empty_individual.Position=[];

pop=repmat(empty_individual,nPop,1);

    for i=1:nPop    
        % Initialize Position
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
    end