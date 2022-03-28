df_real = @(x)(exp(x));
df = @(x0,h)((-25*exp(x0)+48*exp(x0+h)-36*exp(x0+2*h)+16*exp(x0+3*h)-3*exp(x0+4*h))/(12*h));
x = []; y = []; h0 = 1e-16;% h = [1:1000:1e7] * h0;
for i = 1:15
    h0 = h0 * 10;
    for j = 1:999
        h = h0*(1+0.01*j);
        y = [y df_real(1) - df(1,h)];
        x = [x h];
    end
end
semilogx(x, y, 'LineWidth', 1)
xlabel('h')
ylabel('Error')
grid on

loc = find(y==min(abs(y)));
fprintf('The value of h with the minimum approximation error:\t %e\n',x(loc));
fprintf('The value of h derived by us:\t %e\n', (2^(-52))^(0.2));
