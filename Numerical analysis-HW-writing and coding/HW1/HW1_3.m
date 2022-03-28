f = @(x)((1-cos(x))./x.^2);
df = @(x)((x.^2.*sin(x)-2.*x+2.*x.*cos(x))./x.^4);
ddf = @(x)((x.^2.*cos(x)-6.*cos(x)+6 - 4.*x.*sin(x))./x.^4);
x = []; y = []; x0 = 1e-1; a = 1e-15;
for i = 0:13
    tmp = a * 10^(i);
    for j = 0:4
        loc = tmp * (1 + j * 2);
        answer = f(x0) + df(x0)*(loc - x0) + 1/2*ddf(x0)*(loc-x0).^2;
        x = [x, loc]; y = [y, answer];
    end
end
semilogx(x, y, 'LineWidth', 2)
xlabel('x')
ylabel('y')
grid on
% ylim([-5,5]);
% semilogx(x, y, 'LineWidth', 2)
