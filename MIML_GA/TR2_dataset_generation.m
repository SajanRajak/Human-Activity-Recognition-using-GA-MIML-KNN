data = load('sample_newdata.mat');
data_a = data.train_bags;
data_b = data.train_target;

data_b = data_b';
TR2_train_bags = data_a;
TR2_train_target = data_b;
k=1; l=1
for i=1:323
    count = 0;
    for j=1:5
        if(data_b(i,j) == 1)
            count = count+1;
        end
    end
    if(count == 3)
       TR2_test_bags(k) =  data_a(i);
       for j=1:5
          TR2_test_target(k,j) = data_b(i,j); 
       end
       k = k+1;
    else
       TR2_train_bags(l) =  data_a(i);
       for j=1:5
          TR2_train_target(l,j) = data_b(i,j); 
       end
       l = l+1;
    end
end

train_bag = {};
train_target = zeros(280,5);
test_bag = {};
test_target = zeros(43,5);

for i=1:43
    test_bag(i) = TR2_test_bags(i);
    for j=1:5
         test_target(i,j) = TR2_test_target(i,j);
    end
end

for i=1:280
    train_bag(i) = TR2_train_bags(i);
    for j=1:5
         train_target(i,j) = TR2_train_target(i,j);
    end
end

test_bag = test_bag';
test_target = test_target';
train_bag = train_bag';
train_target = train_target';
