function randomnumber(~)
m = matfile('sample_newdata.mat','Writable',true);

%A = randi(100,r,c);
A=randperm(320);
%disp(A);
save('sample_newdata.mat' ,'-append','A');
train_cv  = cell(323,1);
% t=zeros(17,32);
 m.train_bags(180,1)=train_cv(2,1);
% =train_cv{1:20,1:1};
 %=train_cv(1,1);
%disp(temp);
% celldisp(train_cv);
%for i=1:320
   
 %   p=A(i);
  %  disp(p);
   % disp(i);
   % m.train_bags(p,1)=train_cv(i,1);
  %  disp(t);
   % t= train_cv(i,1);
%end
%disp(p);
%disp(t);
save('sample_newdata.mat' ,'-append','train_cv');
%A = repmat(num2cell(rand(11,1)),1,11)
%raw(3:5,2:4)=data
