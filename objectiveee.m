function obj = objectiveee(d)

global y number_of_day
[common, days]=predRecoveryErr_my(d);
init=common(1);
[m,n]=size(y);
% pred1=sol.y(1,[1:end]);
% pred2=sol.y(2,[1:end]);
% pred3=pred1+pred2;
pred=ff2(init,days,common,m,number_of_day);

% if exist('y','var')

if ~exist('s','var')
    s = ones(size(y));
end
obj = (sum(sum((pred(:)-y(:)).^2./s.^2)))/m;
% else
%     err = NaN;

end