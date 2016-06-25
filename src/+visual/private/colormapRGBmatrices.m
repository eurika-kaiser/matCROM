 function mymap = colormapRGBmatrices( N, rm, gm, bm)
 % Creat colormap
 % INFO:
%  It expects 4 input parameters: N is the number of intermediate points that your colormap should 
%  have. The other three are matrices that contain the transitions for each channel. Such a matrix 
%  should have the following form:
% 
% M = [ 0, b1;
%       x1,b2;
%       ...
%       x_n, b_(n+1);
%       1, b_(n+1);
%     ];
%  the first column give the fractions, where a brightness value should be defined. The second column 
%  should contain the brightness levels. Make sure to start the first column at 0 and end it with 1!
%
% EXAMPLES:
% 
% 1) linear grayscale map
% M = [0,0;1,1;];
% simplegray = colormapRGBmatrices( 256, M, M, M);
%
% 2) Improvement of hot colormap
% Now we want to pronounce the second intensity ring a little bit more. This can be done by adding 
% one extra node point in the red channel, which creates a strong gradient in color and brightness. 
% We set the matrices as follows
%  MR=[0,0; 
%     0.02,0.3; %this is the important extra point
%     0.3,1;
%     1,1];
% MG=[0,0;
%     0.3,0; 
%     0.7,1;
%     1,1];
% MB=[0,0; 
%     0.7,0;
%     1,1];
% hot2 = colormapRGBmatrices(500,MR,MG,MB);
% 
% showRGBchannels(2,hot2);
%
% 3) Blueish hot2
% There are more easy modifications. Assume, you make a presentation and are bound to some given 
% corporate design (e.g. blue-white or so). You can switch the order of the matrices to generate 
% colormaps exhibiting the overall same brightness gradient but with different colors. Lets make a 
% blueish 'hot2' map:
% 
% bluehot = colormapRGBmatrices(mcolors,MB,MG,MR);

  x = linspace(0,1, N);
  rv = interp1( rm(:,1), rm(:,2), x);% x,y,xi - >yi
  gv = interp1( gm(:,1), gm(:,2), x);
  mv = interp1( bm(:,1), bm(:,2), x);
  mymap = [ rv', gv', mv'];
  %exclude invalid values that could appear
  mymap( isnan(mymap) ) = 0;
  mymap( (mymap>1) ) = 1;
  mymap( (mymap<0) ) = 0;
end