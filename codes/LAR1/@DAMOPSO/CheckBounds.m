function individual = CheckBounds(damopso,individual)

individual(individual<damopso.lowerBounds) = damopso.lowerBounds(individual<damopso.lowerBounds);
individual(individual>damopso.higherBounds) = damopso.higherBounds(individual>damopso.higherBounds);

end

