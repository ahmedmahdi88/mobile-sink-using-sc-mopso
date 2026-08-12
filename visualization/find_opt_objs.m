function optimal_objectives= find_opt_objs(s,pfsc,pfmo,pfmmo,pfn2)
ob1=[pfsc{s}(:,1);pfmo{s}(:,1);pfmmo{s}(:,1);pfn2{s}(:,1)];
ob2=[pfsc{s}(:,2);pfmo{s}(:,2);pfmmo{s}(:,2);pfn2{s}(:,2)];
ob3=[pfsc{s}(:,3);pfmo{s}(:,3);pfmmo{s}(:,3);pfn2{s}(:,3)];
ob4=[pfsc{s}(:,4);pfmo{s}(:,4);pfmmo{s}(:,4);pfn2{s}(:,4)];
ob5=[pfsc{s}(:,5);pfmo{s}(:,5);pfmmo{s}(:,5);pfn2{s}(:,5)];
optimal_objectives=[min(ob1),min(ob2),min(ob3),min(ob4) min(ob5)];
end
