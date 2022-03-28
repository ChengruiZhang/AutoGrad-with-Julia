% Natural cubic Spline; Input: function f, sub_interval n, x_range; Output:
% figure for the natural spline, real function, and polynomial interpolation
% t: 1e-4, if_plot: 1 if u want to see the figure
function [output_f, output_p, output_s, P_2] = HW3_1(t, if_plot)
%% input
f = @(x)(1./(1+x.^2)); n = 10; x_min = -5; x_max = 5;
a = zeros(n,1); b = zeros(n,1); c = zeros(n+1,1); d = zeros(n,1); r = zeros(n-1,1); 
A = zeros(n-1,n-1); h = (x_max - x_min)/n;

%% find polynomial P
for i = 1 : n-1
    if i == 1, A(i, 1:2) = [4*h, h];
    else, if i == n-1, A(i, n-2:n-1) = [h, 4*h];
          else, A(i, i-1:i+1) = [h, 4*h, h];
          end
    end
    r(i) = 3/h*(f(x_min + h*(i+1))-2*f(x_min + h*i)+f(x_min + h*(i-1)));
end
c(2:end-1,1) = Gaussian(A, r);

%% 
for i = 1 : n
    a(i) = f(x_min + h*i); d(i) = (c(i+1)-c(i))/(3*h);
    b(i) = (f(x_min+h*i)-f(x_min+h*(i-1)))/h + (2*c(i+1)+c(i))*h/3;
end
P_2 = @(x, i)(a(i) + b(i).*(x - (x_min + i*h)) + c(i+1).*(x - (x_min + i*h)).^2 + d(i).*(x - (x_min + i*h)).^3);

%% figure for cubic spilne
x1 = x_min:t:x_max;
output_s = zeros(1, length(x1));
for i = 1:length(x1)-1
    output_s(i) = P_2(x1(i), floor((x1(i)-x_min)/h)+1);
end
if if_plot
    plot(x1, output_s,'LineWidth',1), hold on, grid on
end
%% figure for polynomial
[x2, output_f, output_p] = HW2_5(t);
if if_plot
    plot(x2, output_p,'LineWidth',1)
    plot(x2, output_f,'LineWidth',1)
    xlabel('x'); ylabel('y');
    legend('Cubic Spline Line', 'P(x)','1/(1+x^2)');
end
end

function x = Gaussian(A, b)
A2 = [A,b]; n = length(A); x = zeros(n, 1);
for j = 1 : n
    [~, max_loc] = max(A2(j:end,j)); % find the location of maximum value of column j
    max_loc = max_loc + j - 1;
    for i = j : n % only j:n rows
        if i == max_loc, continue; end
        A2(i,:) = A2(i,:) - A2(i,j)/A2(max_loc, j) * A2(max_loc, :);
    end
    A2(max_loc, :) = A2(max_loc, :) / A2(max_loc, j);
    tmp = A2(j, :); A2(j,:) = A2(max_loc,:); A2(max_loc, :) = tmp;
end
%% back substitution
b = A2(:,n+1); A = A2(:,1:n);
for i = n:-1:1
    if i == n, x(n, 1) = b(n); continue; end
    x(i,1) = b(i) - A(i,i+1:n)*x(i+1:n,1);
end
end

function [x, y, output] = HW2_5(t)
% f = @(x)(sin(x));
f = @(x)(1./(1+x.^2));
DD = divide_difference;
x = -5:t:5;
output = P(x, 1, -5:5, DD(1,2:end));
y = f(x);
end

function DD = divide_difference
%% initialization
% f = @(x)(sin(x));
f = @(x)(1./(1+x.^2));
x_in = -5:5; y = f(x_in); degree = 10; DD = zeros(length(x_in), degree + 2);
for i = 1 : length(x_in)
    DD(i, 1:2) = [x_in(i), y(i)]; 
end

%% iteration
for j = 3 : degree + 2 % column
    for i = 1 : length(x_in) - j + 2 % row
        DD(i, j) = (DD(i+1,j-1) - DD(i,j-1)) / (DD(i+j-2,1) - DD(i,1));
    end
end
% output = P(x, 1, x_in, DD(1,2:end));
end

%% result
function y = P(x, i, x_in, a)
if i == 12
    y = 0; return;
else
    y = a(i) + (x - x_in(i)) .* P(x, i+1, x_in, a);
end
end