function ModelError(CROM)

[CROM.d2,CROM.t,CROM.tau] = determineModelError(CROM.P,CROM.c1_Centroids,CROM.c1_Labels, CROM.Data.ts, CROM.Data.dt);

end