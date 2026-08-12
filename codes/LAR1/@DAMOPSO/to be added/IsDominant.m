function state = IsDominant(moga,solution1ObjValues,solution2ObjValues)
% Check if the first solution (solution1ObjValues) 
% dominates the second one (solution2ObjValues)

if all(solution1ObjValues<=solution2ObjValues) && any(solution1ObjValues<solution2ObjValues)
    state = true;
else
    state = false;
end

end

