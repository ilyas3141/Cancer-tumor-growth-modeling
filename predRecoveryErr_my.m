%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% function [err,pred] = predRecoveryErr_my(d,tt,y,time_span,x_1_0,x_2_0,x_3_0,x_4_0)
function [common, amount_of_days] = predRecoveryErr_my(d)

global time_span x1_0 x2_0 x3_0 x4_0 
in_1=x1_0;
in_2=x2_0;
in_3=x3_0;
in_4=x4_0;
%model goes here. 
common=[];
[qq, qqq] = size(time_span);
amount_of_days=0;
for i = 1:qq
sol=ode45(@(t,x) f(t,x,d), time_span(i,[1:end]), [in_1;in_2;in_3;in_4]);
common=[common sol.y(1,[1:end])+sol.y(2,[1:end])];
in_1=sol.y(1,end);
in_2=sol.y(2,end);
in_3=sol.y(3,end)+8;
in_4=sol.y(4,end);
amount_of_days=time_span(i,end)+amount_of_days;
end


% %amount_of_days=abs(time_span(1)-time_span(end));
% [dim1, dim2]=size(y);
% % pred1=sol.y(1,[1:end]);
% % pred2=sol.y(2,[1:end]);
% % pred3=pred1+pred2;
% pred=ff2(init,amount_of_days,common,dim2,number_of_day);
% 
% % if exist('y','var')
% [m,n]=size(y);
% if ~exist('s','var')
%     s = ones(size(y));
% end
% err = (sum(sum((pred(:)-y(:)).^2./s.^2)))/n;
% % else
% %     err = NaN;

end