clc, clear all
%% initialization
x_in = [-2,-1,1,2]; y = [-6,-3,5,10]; DD = zeros(length(x_in), length(x_in)+1);
for i = 1: length(x_in)
    DD(i,1) = x_in(i); DD(i,2) = x_in(i)*y(i);
end

%% iteration
for j = 3:length(x_in)+1
    for i = 1:length(x_in)-j+2
        DD(i, j) = (DD(i+1,j-1) - DD(i,j-1)) / (DD(i+j-2,1) - DD(i,1));
    end
end

%% result
Q = @(x)(1/x*(DD(i,2) + DD(i,3)*(x-x_in(1))+ DD(i,4)*(x-x_in(1))*(x-x_in(2))+ DD(i,5)*(x-x_in(1))*(x-x_in(2))*(x-x_in(3))));
syms x
y = 1/x*(DD(i,2) + DD(i,3)*(x-x_in(1))+ DD(i,4)*(x-x_in(1))*(x-x_in(2))+ DD(i,5)*(x-x_in(1))*(x-x_in(2))*(x-x_in(3)));
disp(collect(y,x))
% A = zeros(4,4); b = zeros(4,1);
% for i = 1 : 4
%     A(i, :) = [1/x(i), 1, x(i), x(i)^2]; b(i) = y(i);
% end
% inv(A)*b