function daugianariai
    clear all
    close all
    clc
    
    hold on;
    grid on;

    f = @(x)(sin(2*x)/((x+1)^2));

    from = 0;
    to = 10;
    mMin = 1;
    mMax = 20;
    paintAt = [ 5, 20, 50 ];
    figureCount = 1;
    
    n = 250;
    pointsX = linspace(from, to, n);
    pointsY = zeros(n, 1);
    for i = 1:n
        pointsY(i) = f(pointsX(i));
    end
    
    n = 500;
    pointsX2 = linspace(from, to, n);
    for i = 1:n
        pointsY2(i) = f(pointsX2(i));
    end
    deltas = zeros(mMax, 1);
    
    for m = mMin:mMax
        G = base(m, pointsX);
        c = (G' * G) \ (G' * pointsY);

        approximatedY = base(m, pointsX2) * c;
        
        for i = 1:length(approximatedY)
            delta = pointsY2(i) - approximatedY(i);
            deltas(m) = deltas(m) + delta * delta;
        end
    end
    
    figure(1);
    grid on;
    hold on;      
    plot(pointsX, pointsY, 'go');
    plot(pointsX2, approximatedY, 'r-');
    
    figure(2);
    grid on;
    hold on;
    
    deltaX = mMin:mMax;
    deltaY = deltas(mMin:mMax);
    plot(deltaX, deltaY, 'b-');
end

    
function G = base(m, x)
    for i = 1:m
        G(:, i) = x.^(i - 1);
    end
end