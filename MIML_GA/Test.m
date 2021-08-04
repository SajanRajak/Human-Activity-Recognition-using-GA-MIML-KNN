[load('All Feature.mat','pop')];
newPop=pop;

data = load('sample_newdata.mat');
data_a = data.train_bags;
data_b = data.train_target;

empty_individual.Position=[];
empty_individual.Cost=[];
empty_individual.z=[];
empty_individual.Predicted_Labels=[];
empty_individual.Actual_Test_Labels=[];

pop=repmat(empty_individual,20,1);

    for i=1:20
        pop(i).Position = newPop.Position;
        pop(i).Cost = newPop.Cost;
        pop(i).z = newPop.z;
        [pop(i).Cost,pop(i).z,pop(i).Predicted_Labels,pop(i).Actual_Test_Labels]=feature_selection_new( pop(i).Position,data_a,data_b );
    end
