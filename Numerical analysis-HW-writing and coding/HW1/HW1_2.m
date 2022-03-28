f = @(x)((1-cos(x))./x.^2);
x = []; y = [];
a = 1e-15;
for i = 0:13
    tmp = a * 10^(i);
    for j = 0:499
        loc = tmp * (1 + j * 0.02);
        x = [x, loc]; y = [y, f(loc)];
    end
end

semilogx(x, y, 'LineWidth', 1)
xlabel('x')
ylabel('y')
grid on