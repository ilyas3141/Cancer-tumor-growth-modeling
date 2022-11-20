function dydt=f(~,x,d)
 a=d(1);
 b=d(2);
 bk=0;
 n=d(3);
 ED_50=d(4);
 k1=d(5);
 k2=d(6);
 w=d(7);
 c=d(8);
 cons=d(9);
 %cons1=d(10);
% dydt=[(a-n)*x(1)-b*x(1)*x(3)/(ED_50+x(3));
%     n*x(1)+b*x(1)*x(3)/(ED_50+x(3))-w*x(2);
%     -(c+k1)*x(3)+k2*x(4)-bk*x(1)*x(3)/(ED_50+x(3));
%     k1*x(3)-k2*x(4)]
% Mendelsohn
 dydt=[(a-n)*x(1)^cons-b*x(1)*x(3)/(ED_50+x(3));
     n*x(1)^cons+b*x(1)*x(3)/(ED_50+x(3))-w*x(2);
     -(c+k1)*x(3)+k2*x(4)-bk*x(1)*x(3)/(ED_50+x(3));
     k1*x(3)-k2*x(4)]

% Linear
% dydt=[((a-n)*x(1))/(x(1)+cons)-b*x(1)*x(3)/(ED_50+x(3));
%     n*x(1)/(x(1)+cons)+b*x(1)*x(3)/(ED_50+x(3))-w*x(2);
%     -(c+k1)*x(3)+k2*x(4)-bk*x(1)*x(3)/(ED_50+x(3));
%     k1*x(3)-k2*x(4)]

% Surface
% dydt=[((a-n)*x(1))/(x(1)+cons)^(1/3)-b*x(1)*x(3)/(ED_50+x(3));
%     n*x(1)/(x(1)+cons)^(1/3)+b*x(1)*x(3)/(ED_50+x(3))-w*x(2);
%     -(c+k1)*x(3)+k2*x(4)-bk*x(1)*x(3)/(ED_50+x(3));
%     k1*x(3)-k2*x(4)]

% Gompertz
% dydt=[(a-n)*x(1)*log(cons/(x(1)+cons1))-b*x(1)*x(3)/(ED_50+x(3));
%     -n*x(1)*log(cons/(x(1)+cons1))+b*x(1)*x(3)/(ED_50+x(3))-w*x(2);
%     -(c+k1)*x(3)+k2*x(4)-bk*x(1)*x(3)/(ED_50+x(3));
%     k1*x(3)-k2*x(4)]

% Bertalanffy
% dydt=[(a-n)*x(1)^(2/3)-cons*x(1)-b*x(1)*x(3)/(ED_50+x(3));
%     n*x(1)^(2/3)+b*x(1)*x(3)/(ED_50+x(3))-w*x(2);
%     -(c+k1)*x(3)+k2*x(4)-bk*x(1)*x(3)/(ED_50+x(3));
%     k1*x(3)-k2*x(4)]

% % Logistic
% dydt=[(a-n)*x(1)*(1-x(1)/cons)-b*x(1)*x(3)/(ED_50+x(3));
%     n*x(1)*(1-x(1)/cons)+b*x(1)*x(3)/(ED_50+x(3))-w*x(2);
%     -(c+k1)*x(3)+k2*x(4)-bk*x(1)*x(3)/(ED_50+x(3));
%     k1*x(3)-k2*x(4)]



end


