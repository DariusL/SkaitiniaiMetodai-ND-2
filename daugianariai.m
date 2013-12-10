function daugianariai
    clear all
    close all
    clc
    hold on;
    grid on;
    f = @(x)(sin(2.*x)./((x+1).^2));
    from = 0;
    to = 10;
    mMin = 1;
    mMax = 20;
    paintAt = [ 5, 9, 12, 20 ];
    figureCount = 1;
    pointsX = linspace(from, to, 20);
    pointsY = f(pointsX)';
    pointsX2 = linspace(from, to, 200);
    pointsY2 = f(pointsX2)';
    deltas = zeros(mMax, 1);
    
    for m = mMin:mMax
        G = base(m, pointsX);
        c = (G' * G) \ (G' * pointsY);

        approximatedY = base(m, pointsX2) * c;
        for i = 1:length(paintAt)
            if paintAt(i) == m
                for j = 1:length(c)
                    fprintf(1, '%2.8f\r\n', c(j));
                end
                figure(figureCount);
                grid on;
                hold on;
                figureCount = figureCount + 1;
                plot(pointsX, pointsY, 'go');
                plot(pointsX2, approximatedY, 'r-');
                legend('Duoti taskai', 'Aproksimuota funkcija');
            end
        end
        
        for i = 1:length(approximatedY)
            delta = pointsY2(i) - approximatedY(i);
            deltas(m) = deltas(m) + delta * delta;
        end
    end
    
    figure(figureCount);
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