function colormap = getColormapForCTM()

% ---------------------------------------- %
% --- Colormap for CTM and its dynamics -- %
% ----@created 2013-09-08 EK ------------- %
% ---------------------------------------- %


Npts = 500; 
MR=[0,0.7;
    0.5,1; %this is the important extra point, yellow
    1,0.9];
MG=[0,1;
    0.5,1; %this is the important extra point, ywlolo
    1,0];
MB=[0,0.5;
    0.5,0; %this is the important extra point, yellow
    1,0];
colormap = colormapRGBmatrices( Npts, MR, MG, MB); %Colormap for P; RGB CHART