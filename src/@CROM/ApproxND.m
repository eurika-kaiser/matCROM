function ApproxND(CROM, rDim, iAlpha)
if nargin == 1
    rDim  = [2]; %utils.Parameters.instance.parameters.rDim
    iAlpha = [1 2]; %utils.Parameters.instance.parameters.rVec
end
[CROM.ts_r,CROM.c1_Centroids_r] = CROM.compLowOrderRepresentation(CROM.Data.ts,CROM.c1_Centroids,rDim, iAlpha);
end