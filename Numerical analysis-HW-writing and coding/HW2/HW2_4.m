clc, clear all
%% initialization
x = [1, 2]; p = [1, 2]; dp = [2, 4];
degree = 3; DD = zeros(2*length(x) + 1, degree + 2);
for i = 1 : length(x)
    DD(2*i-1, 1) = x(i); DD(2*i-1, 2) = p(i);
    DD(2*i, 1) = x(i); DD(2*i, 2) = p(i);
end
%% iteration
for i = 1 : 2*length(x) - 1
    if mod(i, 2) ~= 0
        DD(i, 3) = dp(ceil(i/2));
    else
        DD(i, 3) = (DD(i+1,2) - DD(i,2)) / (DD(i+1,1) - DD(i,1));
    end
end
for j = 4 : degree + 2 % column
    for i = 1 : 2*length(x) - j + 2 % row
        DD(i, j) = (DD(i+1,j-1) - DD(i,j-1)) / (DD(i+j-2,1) - DD(i,1));
    end
end

%% result
P = @(x)(DD(1,2) + DD(1,3)*(x - p(1)) + DD(1,4)*(x - p(1))^2 + DD(1,5)*(x - p(1))^2*(x - p(2)));
syms x
y = DD(1,2) + DD(1,3)*(x - p(1)) + DD(1,4)*(x - p(1))^2 + DD(1,5)*(x - p(1))^2*(x - p(2));
disp(collect(y,x))