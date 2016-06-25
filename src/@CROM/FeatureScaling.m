function [minval,maxval] = FeatureScaling(CROM)
maxval = max(CROM.Data.ts);
minval = min(CROM.Data.ts);
for i = 1:size(CROM.Data.ts,2)
    CROM.Data.ts(:,i) =  (CROM.Data.ts(:,i)-minval(i))./(maxval(i)-minval(i));
end