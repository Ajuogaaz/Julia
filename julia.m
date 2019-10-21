% Homework Program 4
%
% Name: Linus Brian Okoth
% Section: 30
% Date: 10/20/2019

function [EscTime, EscValue, Image] = julia(c, limits, nx, ny, maxEscTime)

if ~exist('limits','var') || isempty(limits)
    R = (1+sqrt(1+4*abs(c)))/2;
    limits = [-R R -R R];
end

if ~exist('nx','var') || isempty(nx)
    nx = 1024;
end

if ~exist('ny','var') || isempty(ny)
    ny = 1024;
end

if ~exist('maxEscTime','var') || isempty(maxEscTime)
    maxEscTime = 1000;
end

x = linspace(limits(1),limits(2),nx);
y = linspace(limits(4),limits(3),ny);

[X,Y] = meshgrid(x,y);
Z = X + 1i*Y;

EscTime = Inf(ny, nx);
EscValue = NaN(ny, nx);

done = false(ny , nx);

for k = 1 : maxEscTime
    Z = Z.^2 + c;
    
    new = abs(Z) > R & ~(done);
    
    EscTime(new) = k;
    EscValue(new) = abs(Z(new));
    
    done(done | new) = true;
    
    if all(done)
        break
    end
end  

% Plot result as a color image
%
Image = showJulia(EscTime,EscValue,limits);
    
end










