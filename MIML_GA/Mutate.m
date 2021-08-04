function y = Mutate(x,mu)
    nVar=numel(x);
    nmu=ceil(mu*nVar);
    j=randsample(nVar-2,nmu);
    j1=randsample(nVar-1:nVar,1);
    val = randi([1 20],1);
    y=x;
    
    %multiple bit flipping
    y(j)=1-x(j);
    
    %citer or reference change
    y(j1) = val;
end