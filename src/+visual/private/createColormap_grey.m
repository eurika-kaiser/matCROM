function cmap = createColormap_grey(Mmin,Mmax,Ncolors)

Mvec = [Mmin:(Mmax-Mmin)/(Ncolors-1):Mmax]';

cmap = repmat(Mvec,[1 3]);