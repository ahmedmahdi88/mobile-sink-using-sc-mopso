function individual = CheckBounds(mopso,individual)

individual(individual<mopso.lowerBounds) = mopso.lowerBounds(individual<mopso.lowerBounds);
individual(individual>mopso.higherBounds) = mopso.higherBounds(individual>mopso.higherBounds);

end

