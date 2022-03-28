f = @(x,w)(cos(w*x));
g = @(x,w)(cos(pi*w/8*(x+1)));
y = zeros(length(1:1:1000)); i =1;

for w = 1
    f2 = @(x)(cos(w*x));
    I1 = integral(f2, 0, pi/4); % disp(I1);
    I2 = pi/8*(f(pi/8*(1/3^0.5+1),w) + f(pi/8*(1-1/3^0.5),w));
    disp(abs(I2-I1))
end
y2 = zeros(1000);
for w = 1:1:1000
    f2 = @(x)(cos(w*x));
    I1 = integral(f2, 0, pi/4); % disp(I1);
    I2 = pi/8*(f(pi/8*(1/3^0.5+1),w) + f(pi/8*(1-1/3^0.5),w)); % disp(I2);
%     I3 = pi/8*(g(1/3^0.5,w) + g(-1/3^0.5,w));
    y(i) = abs(I2-I1); i = i+1;
end
plot(1:1:1000, y), grid on

% I3 = g(1/3^0.5) + g(-1/3^0.5);
% disp(abs(I2-I1));
% disp(abs(I3-I2));