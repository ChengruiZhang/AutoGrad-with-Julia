function HW7_3
close all
f = @(x, y)((x - 1).^2 / 2 + (10*(y - x.^2)).^2/2 + y.^2/2);
J = @(x, y)([200*x.^3 - 200 * x * y + x - 1; -100*x.^2 + 101 * y]);
H = @(x, y)([600*x.^2 - 200 * y + 1, -200 * x; -200*x, 101]);
M = @(x, y)([400*x.^2 + 1, -200 * x; -200 * x, 101]);
R = @(x, y)([x-1; 10*(y - x.^2); y]);
JR = @(x, y)([1, 0; -20*x, 10; 0, 1]);

%% Q2
tic
x1 = zeros(1, 200); y1 = zeros(1, 200); x1(1) = -1; y1(1) = -1; leng = 1;
while norm(J(x1(leng), y1(leng)), 2) > 1e-3 && leng < 200
    leng = leng + 1;
    tmp = -inv(H(x1(leng - 1), y1(leng - 1))) * JR(x1(leng - 1), y1(leng - 1))' * R(x1(leng - 1), y1(leng - 1));
    x1(leng) = x1(leng - 1) + tmp(1); y1(leng) = y1(leng - 1) + tmp(2);
end
if leng < 200
    x1(leng+1:end) = []; y1(leng+1:end) = [];
end
time1 = toc;
plot(x1, y1)
grid on
%% Q3
tic
x2 = zeros(1, 200); y2 = zeros(1, 200);
x2(1) = -1; y2(1) = -1;
leng = 1; 
while norm(J(x2(leng), y2(leng)), 2) > 1e-3 && leng < 200
    leng = leng + 1;
    tmp = -inv(M(x2(leng - 1), y2(leng - 1))) * JR(x2(leng - 1), y2(leng - 1))' * R(x2(leng - 1), y2(leng - 1));
    x2(leng) = x2(leng - 1) + tmp(1); y2(leng) = y2(leng - 1) + tmp(2); 
end
if leng < 200
    x2(leng+1:end) = []; y2(leng+1:end) = [];
end
time2 = toc; 
diff = zeros(1, leng);
for i = 1 : leng
    diff(i) = norm(H(x2(i), y2(i)) - M(x2(i), y2(i)), 2);
end
hold on, plot(x2, y2)
legend('Newton''s method','Gauss Newton''s method')
xlabel('x'); ylabel('y'); title('Two iteration methods')
figure, plot(1:leng, diff), grid on
xlabel('iteration\_number'); ylabel('Norm(H-M, 2)')
title('The difference between exact and approximate Hessian ')
end