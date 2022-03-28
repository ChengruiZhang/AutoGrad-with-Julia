% LU decomposition solution of linear system [A, b]
function x = HW6 % u can add input(A, b) if u want
A = [1, -2, 1; 2, 1, -3; 4, -7, 1]; b = [0, 5, -1]';
x = LU_self(A, b);
end


%% Gauss func
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
    tmp = A2(j, :); A2(j,:) = A2(max_loc, :); A2(max_loc, :) = tmp;
end
%% back substitution
b = A2(:,n+1); A = A2(:,1:n);
for i = n:-1:1
    if i == n, x(n, 1) = b(n); continue; end
    x(i,1) = b(i) - A(i,i+1:n)*x(i+1:n,1);
end
end


%% LU func
function x = LU_self(A, b)
n = length(A); x = zeros(n, 1); A2 = A; P = zeros(n,n); P1 = (1:n)'; L = eye(n,n);
for j = 1 : n
    [~, max_loc] = max(A2(j:end,j)); % find the location of maximum value of column j
    max_loc = max_loc + j - 1;
    tmp1 = A2(j, :); A2(j, :) = A2(max_loc, :); A2(max_loc, :) = tmp1;
    tmp2 = P1(j, :); P1(j, :) = P1(max_loc, :); P1(max_loc, :) = tmp2;
    for i = j + 1 : n
        a = A2(i,j)/A2(j,j); A2(i, j:end) =  A2(i, j:end) - a * A2(j, j:end); A2(i, j) = a;
    end
end
for i = 2:n
    L(i,1:i-1) = A2(i, 1:i-1); A2(i, 1:i-1) = 0;
end
for i = 1 : n
    P(i, P1(i)) = 1;
end

%% forward substitution
U = A2; y = zeros(n,1); b = P * b;
for i = 1: n
    if i == 1, y(1, 1) = b(1); continue; end
    y(i,1) = b(i) - L(i, 1:i-1)*y(1:i-1,1);
end

%% backward substitution
x = Gaussian(U, y);

end
