%periodinis pirmos eiles defekto splainas
function splainai
    clc, close all, clear all

    xmin=-5;
    xmax=5;
    n=9;
    t = linspace(xmin, xmax, n);
    X = @(t)(t./5 .* sin(t));
    Y = @(t)(t./5 .* cos(t));
    x = X(t);
    y = Y(t);

    figure(1)
    hold on
    grid on
    plot(x, y, 'o');

    figure(2)
    hold on
    grid on

    plot(t, x, 'go');
    plot(t, y, 'bo');

    tt = linspace(xmin, xmax, 300);
    plot(tt, X(tt), 'g-');
    plot(tt, Y(tt), 'b-');
    legend('', '', 'X(t)', 'Y(t)');
    figure(1)
    DDFX=splaino_koeficientai(t, x);
    DDFY=splaino_koeficientai(t, y);
    for i=1:n-1
        SplainoX=splainas(t(i:i+1),x(i:i+1),DDFX(i:i+1));
        SplainoY=splainas(t(i:i+1),y(i:i+1),DDFY(i:i+1));
        plot(SplainoX,SplainoY)
    end
end

function S=splainas(x, y, DDF)
    nnn=100;
    d=x(2)-x(1);
    xxx=x(1):d/(nnn-1):x(2);
    sss=xxx-x(1);
    S=DDF(1)*(sss.^2/2-sss.^3/(6*d)) + DDF(2)*sss.^3/(6*d)+...
        ((y(2)-y(1))/d-DDF(1)*d/3-DDF(2)*d/6)*sss+...
        y(1);
end

function DDF=splaino_koeficientai(X,Y)
    n=length(X);
    A=zeros(n);b=zeros(n,1);
    d=X(2:n)-X(1:(n-1));
    for i=1:n-2
        A(i,i:i+2)=[d(i)/6, (d(i)+d(i+1))/3,d(i+1)/6];
        b(i)=(Y(i+2)-Y(i+1))/d(i+1)-(Y(i+1)-Y(i))/d(i);
    end
 
    A(n-1,[1,2,n-1,n])=[d(1)/3, d(1)/6, d(n-1)/6,d(n-1)/3];
    A(n,[1,n])=[1,-1];
    b(n-1)=(Y(2)-Y(1))/d(1)-(Y(n)-Y(n-1))/d(n-1);
    DDF=A\b;      
end