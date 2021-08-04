data=load('new_Heuristic_nSel_10.mat');
newpop=data.pop;

result.activity = [];
result.prediction = [];
result.single = [];
result.prediction_single = [];
result.double = [];
result.prediction_double = [];
result.triple = [];
result.prediction_triple = [];


result.static = [];
result.dynamic = [];
result.static_static = [];
result.static_dynamic = [];
result.dynamic_dynamic = [];
result.static_static_static = [];
result.static_static_dynamic = [];
result.static_dynamic_dynamic = [];

result.prediction_static = [];
result.prediction_dynamic = [];
result.prediction_static_static = [];
result.prediction_static_dynamic = [];
result.prediction_dynamic_dynamic = [];
result.prediction_static_static_static = [];
result.prediction_static_static_dynamic = [];
result.prediction_static_dynamic_dynamic = [];

result.total_single=0;
result.total_double=0;
result.total_triple=0;

result.total_static=0;
result.total_dynamic=0;
result.total_static_static=0;
result.total_static_dynamic=0;
result.total_dynamic_dynamic=0;
result.total_static_static_static=0;
result.total_static_static_dynamic=0;
result.total_static_dynamic_dynamic=0;

result.total_predicted_static=0;
result.total_predicted_dynamic=0;
result.total_predicted_static_static=0;
result.total_predicted_static_dynamic=0;
result.total_predicted_dynamic_dynamic=0;
result.total_predicted_static_static_static=0;
result.total_predicted_static_static_dynamic=0;
result.total_predicted_static_dynamic_dynamic=0;

result.total_predicted_single=0;
result.total_predicted_double=0;
result.total_predicted_double_single=0;
result.total_predicted_triple=0;
result.total_predicted_triple_double=0;
result.total_predicted_triple_single=0;


%%

%sit,stand,walk,jog,lying (1,2,3,4,5)
test = [];
for i = 1:20
    
    result.static(i)=0;
    result.dynamic(i)=0;
    result.static_static(i)=0;
    result.static_dynamic(i)=0;
    result.dynamic_dynamic(i)=0;
    result.static_static_static(i)=0;
    result.static_static_dynamic(i)=0;
    result.static_dynamic_dynamic(i)=0;
    
    result.prediction_static(i)=0;
    result.prediction_dynamic(i)=0;
    result.prediction_static_static(i)=0;
    result.prediction_static_dynamic(i)=0;
    result.prediction_dynamic_dynamic(i)=0;
    result.prediction_static_static_static(i)=0;
    result.prediction_static_static_dynamic(i)=0;
    result.prediction_static_dynamic_dynamic(i)=0;
    
    for j=1:43
        %% Count the number of total activities done in the jth chromosome
        count=0;
        % initially consider
        result.prediction(i,j)=1;
        for k=1:5
            % test array is used for ease of coding
            test(k)=newpop(i).Actual_Test_Labels(k,j);
            if newpop(i).Actual_Test_Labels(k,j)==1
                %% Check if the kth label of jth chromosome is same or not
                if newpop(i).Predicted_Labels(k,j)~=1
                    result.prediction(i,j)=0;
                end
                count=count+1;
            end
        end
        result.activity(i,j)=count;
        new_count=0;
        %% New loop to determine identified activities
        for k=1:5
            if test(k)==1
                if newpop(i).Predicted_Labels(k,j)==1
                    new_count=new_count+1;
                end
            end
        end
        %% Checks of less activity predicted
        if (count==2 && new_count==1)
            result.total_predicted_double_single=result.total_predicted_double_single+1;
        elseif (count==3 && new_count==1)
            result.total_predicted_triple_single=result.total_predicted_triple_single+1;
        elseif (count==3 && new_count==2)
            result.total_predicted_triple_double=result.total_predicted_triple_double+1;
        end
        
        %% get the label (static,static-dynamic,dynamic,dynamic-dynamic)
        if count==1
            if (test(1)==1 || test(2)==1 || test(5)==1)
                %test 1, 2 and 3 are static activities
                result.static(i)=result.static(i)+1;
                if result.prediction(i,j)==1
                   result.prediction_static(i)=result.prediction_static(i)+1; 
                end
            else
                result.dynamic(i)=result.dynamic(i)+1;
                if result.prediction(i,j)==1
                   result.prediction_dynamic(i)=result.prediction_dynamic(i)+1; 
                end
            end
        
        elseif count==2
            if((test(1)==1 && test(2)==1)||(test(1)==1 && test(5)==1)||(test(2)==1 && test(5)==1))
                result.static_static(i)=result.static_static(i)+1;
                if result.prediction(i,j)==1
                   result.prediction_static_static(i)=result.prediction_static_static(i)+1; 
                end
            elseif (test(3)==1 && test(4)==1)
                result.dynamic_dynamic(i)=result.dynamic_dynamic(i)+1;
                if result.prediction(i,j)==1
                   result.prediction_dynamic_dynamic(i)=result.prediction_dynamic_dynamic(i)+1; 
                end
            else
                result.static_dynamic(i)=result.static_dynamic(i)+1;
                if result.prediction(i,j)==1
                   result.prediction_static_dynamic(i)=result.prediction_static_dynamic(i)+1; 
                end
            end
        
        elseif count==3
            if (test(1)==1 && test(2)==1 && test(5)==1)
                result.static_static_static(i)=result.static_static_static(i)+1;
                if result.prediction(i,j)==1
                   result.prediction_static_static_static(i)=result.prediction_static_static_static(i)+1; 
                end
            elseif (test(3)==1 && test(4)==1)
                result.static_dynamic_dynamic(i)=result.static_dynamic_dynamic(i)+1;
                if result.prediction(i,j)==1
                   result.prediction_static_dynamic_dynamic(i)=result.prediction_static_dynamic_dynamic(i)+1; 
                end
            else
                result.static_static_dynamic(i)=result.static_static_dynamic(i)+1;
                if result.prediction(i,j)==1
                   result.prediction_static_static_dynamic(i)=result.prediction_static_static_dynamic(i)+1; 
                end
            end
        end
        
    end
end


%% Evaulating the Result
for i=1:20
    result.single(i)=0;
    result.double(i)=0;
    result.triple(i)=0;
    result.prediction_single(i)=0;
    result.prediction_double(i)=0; 
    result.prediction_triple(i)=0;
    for j=1:32
        if result.activity(i,j)==1
            result.single(i)=result.single(i)+1;
            if result.prediction(i,j)==1
                result.prediction_single(i)=result.prediction_single(i)+1;
            end
        elseif result.activity(i,j)==2
            result.double(i)=result.double(i)+1;
            if result.prediction(i,j)==1
                result.prediction_double(i)=result.prediction_double(i)+1;
            end
        else
            result.triple(i)=result.triple(i)+1;
            if result.prediction(i,j)==1
                result.prediction_triple(i)=result.prediction_triple(i)+1;
            end
        end
    end
end

%% Transposing
result.single=result.single';
result.double=result.double';
result.triple=result.triple';
result.prediction_single=result.prediction_single';
result.prediction_double=result.prediction_double';
result.prediction_triple=result.prediction_triple';

result.static = result.static';
result.dynamic = result.dynamic';
result.static_static = result.static_static';
result.static_dynamic = result.static_dynamic';
result.dynamic_dynamic = result.dynamic_dynamic';
result.static_static_static = result.static_static_static';
result.static_static_dynamic = result.static_static_dynamic';
result.static_dynamic_dynamic = result.static_dynamic_dynamic';

result.prediction_static = result.prediction_static';
result.prediction_dynamic = result.prediction_dynamic';
result.prediction_static_static = result.prediction_static_static';
result.prediction_static_dynamic = result.prediction_static_dynamic';
result.prediction_dynamic_dynamic = result.prediction_dynamic_dynamic';
result.prediction_static_static_static = result.prediction_static_static_static';
result.prediction_static_static_dynamic = result.prediction_static_static_dynamic';
result.prediction_static_dynamic_dynamic = result.prediction_static_dynamic_dynamic';

%% Adding the Results
for i=1:20
    result.total_single=result.total_single+result.single(i);
    result.total_double=result.total_double+result.double(i);
    result.total_triple=result.total_triple+result.triple(i);
    result.total_predicted_single=result.total_predicted_single+result.prediction_single(i);
    result.total_predicted_double=result.total_predicted_double+result.prediction_double(i);
    result.total_predicted_triple=result.total_predicted_triple+result.prediction_triple(i);
    
    result.total_static=result.total_static+result.static(i);
    result.total_dynamic=result.total_dynamic+result.dynamic(i);
    result.total_static_static=result.total_static_static+result.static_static(i);
    result.total_static_dynamic=result.total_static_dynamic+result.static_dynamic(i);
    result.total_dynamic_dynamic=result.total_dynamic_dynamic+result.dynamic_dynamic(i);
    result.total_static_static_static=result.total_static_static_static+result.static_static_static(i);
    result.total_static_static_dynamic=result.total_static_static_dynamic+result.static_static_dynamic(i);
    result.total_static_dynamic_dynamic=result.total_static_dynamic_dynamic+result.static_dynamic_dynamic(i);
    
    result.total_predicted_static=result.total_predicted_static+result.prediction_static(i);
    result.total_predicted_dynamic=result.total_predicted_dynamic+result.prediction_dynamic(i);
    result.total_predicted_static_static=result.total_predicted_static_static+result.prediction_static_static(i);
    result.total_predicted_static_dynamic=result.total_predicted_static_dynamic+result.prediction_static_dynamic(i);
    result.total_predicted_dynamic_dynamic=result.total_predicted_dynamic_dynamic+result.prediction_dynamic_dynamic(i);
    result.total_predicted_static_static_static=result.total_predicted_static_static_static+result.prediction_static_static_static(i);
    result.total_predicted_static_static_dynamic=result.total_predicted_static_static_dynamic+result.prediction_static_static_dynamic(i);
    result.total_predicted_static_dynamic_dynamic=result.total_predicted_static_dynamic_dynamic+result.prediction_static_dynamic_dynamic(i);
end

compact_result.total_single_activity = result.total_single;
compact_result.predicted_single_activilty=result.total_predicted_single;
compact_result.total_double_activity = result.total_double;
compact_result.predicted_double_activilty=result.total_predicted_double;
compact_result.total_triple_activity = result.total_triple;
compact_result.predicted_triple_activilty=result.total_predicted_triple;
compact_result.total_activity_labels = result.total_single + result.total_double + result.total_triple;
compact_result.total_correct_predictions = result.total_predicted_single+result.total_predicted_double+result.total_predicted_triple;

compact_result.total_static=result.total_static;
compact_result.total_predicted_static=result.total_predicted_static;
compact_result.total_dynamic=result.total_dynamic;
compact_result.total_predicted_dynamic=result.total_predicted_dynamic;

compact_result.total_static_static=result.total_static_static;
compact_result.total_predicted_static_static=result.total_predicted_static_static;
compact_result.total_static_dynamic=result.total_static_dynamic;
compact_result.total_predicted_static_dynamic=result.total_predicted_static_dynamic;
compact_result.total_dynamic_dynamic=result.total_dynamic_dynamic;
compact_result.total_predicted_dynamic_dynamic=result.total_predicted_dynamic_dynamic;


compact_result.total_static_static_static=result.total_static_static_static;
compact_result.total_predicted_static_static_static=result.total_predicted_static_static_static;
compact_result.total_static_static_dynamic=result.total_static_static_dynamic;
compact_result.total_predicted_static_static_dynamic=result.total_predicted_static_static_dynamic;
compact_result.total_static_dynamic_dynamic=result.total_static_dynamic_dynamic;
compact_result.total_predicted_static_dynamic_dynamic=result.total_predicted_static_dynamic_dynamic;