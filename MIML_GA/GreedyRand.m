%GreedyRand Function takes VarMin and VarMax (Work for Binary
%Classification only)
%nVar (Total Features/Variables)
%nSel (Total Features/Variables need to be selected)

%function returns a 1XnVar Matrix Position conating VarMin and VarMax

function [Position]=GreedyRand(VarMin,VarMax,nVar,nSel)
    index = randperm(nVar,nSel);
    Position = randi([VarMin VarMin],1,nVar);
    for i=1:nSel
        Position(index(i))= VarMax;
    end
end