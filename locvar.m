function vp = locvar(t,N)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

u=t/N;

erp=1./(N-(N-1)*(1-u).^2);
er=(1-u).^2.*erp;
etp=(N+3*N*(N-1)*er)./(N^3-N*(N-1)*(N-2)*(1-u).^3);
et=(1-u).^3.*etp;
erp2=(N^2+2*(N+1)*N*(N-1).*er+4*N*(N-1)*(N-2).*et)./(N^4-N*(N-1)*(N-2)*(N-3)*(1-u).^4);

vp=erp2-erp.^2;

end

