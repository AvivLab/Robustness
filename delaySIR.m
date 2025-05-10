function sol=delaySIR()
 
lags = [1];
tspan = [0 100];
sol = dde23(@ddex1de, lags, @history, tspan);

end
 
function y = history(t)
  y = [1 50 0];
  
end
 
 
function dydt = ddex1de(t,y,Z)
  ylag1 = Z(:,1);
   m=2e-4; b=0.02; v=0.1; r=0.3;
  dydt = [b*y(2)*ylag1(1)-(m+v)*y(1)-r*y(1); m*(y(1)+y(2)+y(3))-m*y(2)-b*y(2)*ylag1(1); r*y(1)-m*y(3)];
  
end

sol=delaySIR();
sol.x