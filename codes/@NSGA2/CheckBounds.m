function individual = CheckBounds(moga,individual)

individual(individual<moga.lowerBounds) = moga.lowerBounds(individual<moga.lowerBounds);
individual(individual>moga.upperBounds) = moga.upperBounds(individual>moga.upperBounds);

end

