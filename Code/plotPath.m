function plotPath(algoSteps,color)

[r,~] = size(algoSteps);
for i = 1:r
    scatter3(algoSteps(i,2),algoSteps(i,1),...
        function_eval(algoSteps(i,1),algoSteps(i,2)),color,'filled')
end
