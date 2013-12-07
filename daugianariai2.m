function daugianariai2
clc,close all,clear all

xmin=-10;ymin=-10;xmax=10;ymax=10; % koordinaciu sistemos ribos
figure(1),hold on, axis([xmin,xmax,ymin,ymax]);grid on
m=9; %aproksimuojanciu funkciju skaicius bazeje;

% Pele ivedami taskai. Baigiama, kai taskas parenkamas uz koord. sistemos ribu
f = @(x)(sin(2.*x)./((x+1).^2));
X = linspace(0, 10, 50);
Y = f(X);
X = X';
Y = Y';
cla, plot(X,Y,'ko');
n=length(X)   % tasku skaicius

% Maziausiu kvadratu metodo lygciu sistema:
G=base(m,X)
c=(G'*G)\(G'*Y)
sss=sprintf('%5.2g',c(1));
for i=1:m-1
    sss=[sss,sprintf('+%5.2gx^%1d',c(i+1),i)];
end
sss=strrep(sss,'+-','-');
% Aproksimuojanti funkcija:
nnn=200; %vaizdavimo tasku skaicius
xxx=xmin:(xmax-xmin)/(nnn-1):xmax; %vaizdavimo taskai 
Gv=base(m,xxx);
fff=Gv*c;
plot(xxx,fff,'r-');
legend({'duoti taskai',sprintf('f(x)=%s',sss)})
title(sprintf('aproksimavimas maziausiu kvadratu metodu \n  tasku skaicius %d,  funkciju skaicius  %d',n,m));


return
end


function G=base(m,x)
     for i=1:m,  G(:,i)=x.^(i-1); end
return
end