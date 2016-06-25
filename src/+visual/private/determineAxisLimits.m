function MaxVal = determineAxisLimits(Data)

% ------------------------------------- %
% --- determine the limits of the   --- %
% --- axes based on data            --- %
% --- @created: 2013-10-11 EK       --- %
% ------------------------------------- %

valMax = max(max(max(Data)));
valMin = min(min(min(Data)));
MaxVal = max([abs(valMin),abs(valMax)]);
