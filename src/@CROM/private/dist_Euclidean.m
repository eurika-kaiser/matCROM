function dist_ab = dist_Euclidean(a,b)
% ------------------------------------- %
% --- Euclidean distance 	------- %
% ----@created: 2014-02-10 EK --------- %
% --- @revised: 2014-09-19 EK dot ----- %
% ----@depends:                   ----- %
% ------------------------------------- %

if size(a,2)~=1
    a=a';
end
if size(b,2)~=1
    b=b';
end

%dist_ab = sqrt((a-b)'*(a-b));
dist_ab = sqrt(dot(a-b,a-b));
