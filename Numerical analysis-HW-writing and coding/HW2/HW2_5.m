function HW2_5
f = @(x)(sin(x));
% f = @(x)(1./(1+x.^2));
DD = divide_difference;
x = -5:0.01:5;
output = P(x, 1, -5:5, DD(1,2:end));
y = f(x);
plot(x, output,'LineWidth',1), hold on, grid on
plot(x, y,'LineWidth',1)
xlabel('x'); ylabel('y');
% legend('P(x)','1/(1+x^2)');
legend('P(x)','sin(x)');
end

function DD = divide_difference
%% initialization
f = @(x)(sin(x));
% f = @(x)(1./(1+x.^2));
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