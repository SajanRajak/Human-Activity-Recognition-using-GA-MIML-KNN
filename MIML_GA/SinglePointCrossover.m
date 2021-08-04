%
% Copyright (c) 2015, Yarpiz (www.yarpiz.com)
% All rights reserved. Please read the "license.txt" for license terms.
%
% Project Code: YPEA101
% Project Title: Implementation of Binary Genetic Algorithm in MATLAB
% Publisher: Yarpiz (www.yarpiz.com)
% 
% Developer: S. Mostapha Kalami Heris (Member of Yarpiz Team)
% 
% Contact Info: sm.kalami@gmail.com, info@yarpiz.com
%

function [y1, y2]=SinglePointCrossover(x1,x2)
%nVar=numel(x1);
nVar=34;
c1=randi([1 nVar-3]);
y1=[x1(1:c1) x2(c1+1:nVar-2) x1(nVar-1:nVar-1) x2(nVar:nVar)];
y2=[x2(1:c1) x1(c1+1:nVar-2) x2(nVar-1:nVar-1) x1(nVar:nVar)];
end