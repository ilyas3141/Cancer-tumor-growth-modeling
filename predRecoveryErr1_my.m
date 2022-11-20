%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% function [err,common] = predRecoveryErr1_my(d,time_span,x_1_0,x_2_0,x_3_0,x_4_0)
function common = predRecoveryErr1_my(d)

global time_span x1_0 x2_0 x3_0 x4_0

%model goes here. 
common=[];
in_1=x1_0;
in_2=x2_0;
in_3=x3_0;
in_4=x4_0;
[qq, qqq] = size(time_span);
for i = 1:qq
sol=ode45(@(t,x) f(t,x,d), time_span(i,[1:end]), [in_1;in_2;in_3;in_4]);
common=[common sol.y(1,[1:end])+sol.y(2,[1:end])];
in_1=sol.y(1,end);
in_2=sol.y(2,end);
in_3=sol.y(3,end)+8;
in_4=sol.y(4,end);
end
% pred1=pred_0.y(1,[1:end]);
% pred2=pred_0.y(2,[1:end]);
% pred3=pred_0.y(3,[1:end]);
% pred4=pred_0.y(4,[1:end]);
% pred=pred1+pred2;

% if exist('y','var')
%     [m,n]=size(y);
%     if ~exist('s','var')
%        s = ones(size(y));
%     end
% 
%     err = (sum(sum((common(:)-y(:)).^2./s.^2)))/n;
% else
%     err = NaN;

end