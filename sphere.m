%color1=[0,0,1];
%color2=[1,0,0];
color1=[241, 245, 176]/256;
color2=[84, 9, 125]/256;

figure();
hold on;
u=randn(1,300);
v=randn(1,300);
w=randn(1,300);
n=(u.*u+v.*v+w.*w).^(0.5);
x=u./n; y=v./n; z=w./n;
t=(z+1)/2;

for i=1:300
      color=mymap(floor(t(i)*63)+1,:);
      plot(x(i),y(i),".",'Color',color,'MarkerSize',10);
end
