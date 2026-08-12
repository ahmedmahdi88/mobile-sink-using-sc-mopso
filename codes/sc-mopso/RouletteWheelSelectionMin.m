function i=RouletteWheelSelectionMin(P)
weights=1./P;
weights(weights==inf)=max(weights~=inf)+100;
  accumulation = cumsum(weights);
  p = rand() * accumulation(end);
  chosen_index = -1;
  for index = 1 : length(accumulation)
    if (accumulation(index) > p)
      chosen_index = index;
      break;
    end
  end
  choice = chosen_index;
i=choice;
end