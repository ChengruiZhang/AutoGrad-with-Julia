clc
%% P1
disp('************  P1  ***********')
a = 0; b = 0.5; f = @(x)(sin(0.9*x));
A = [1, sin(a), cos(a); 1, sin((a+b)/2), cos((a+b)/2); 1, sin(b), cos(b)]; % A = sym(A, 'f');
B = [f(a), f((a+b)/2), f(b)]';
C = A\B; % disp(C)
I1_1 = C(1)*(b-a) + C(2)*(cos(a)-cos(b)) + C(3)*(sin(b)-sin(a));
alpha = [b-a, cos(a)-cos(b), sin(b)-sin(a)]/A;
I1_2 = alpha*B;
I1_3 = (b-a)/6*(f(a)+4*f((a+b)/2)+f(b));
% disp(abs(integral(f,0,0.5)-I1_1));
fprintf('This new numerical integration error: %e\n', abs(integral(f,a,b)-I1_2));
fprintf('Simpson error: %e\n',abs(integral(f,a,b)-I1_3));

%% P2
disp('************  P2  ***********')
a = 0; b = 1; f = @(x)(x.^3);
A = [1, sin(a), cos(a); 1, sin((a+b)/2), cos((a+b)/2); 1, sin(b), cos(b)]; % A = sym(A, 'f');
B = [f(a), f((a+b)/2), f(b)]';
C = A\B; % disp(C)
I2_1 = C(1)*(b-a) + C(2)*(cos(a)-cos(b)) + C(3)*(sin(b)-sin(a));
alpha = [b-a, cos(a)-cos(b), sin(b)-sin(a)]/A;
I2_2 = alpha*B;
I2_3 = (b-a)/6*(f(a)+4*f((a+b)/2)+f(b));
fprintf('This new numerical integration error: %e\n', abs(integral(f,a,b)-I2_2));
fprintf('Simpson error: %e\n',abs(integral(f,a,b)-I2_3));

%% P3
disp('************  P3  ***********')
a = 0; b = 1; f = @(x)(cos(x));
A = [1, sin(a), cos(a); 1, sin((a+b)/2), cos((a+b)/2); 1, sin(b), cos(b)]; % A = sym(A, 'f');
B = [f(a), f((a+b)/2), f(b)]';
C = A\B; % disp(C)
I3_1 = C(1)*(b-a) + C(2)*(cos(a)-cos(b)) + C(3)*(sin(b)-sin(a));
alpha = [b-a, cos(a)-cos(b), sin(b)-sin(a)]/A;
I3_2 = alpha*B;
I3_3 = (b-a)/6*(f(a)+4*f((a+b)/2)+f(b));
fprintf('This new numerical integration error: %e\n', abs(integral(f,a,b)-I3_2));
fprintf('Simpson error: %e\n',abs(integral(f,a,b)-I3_3));
