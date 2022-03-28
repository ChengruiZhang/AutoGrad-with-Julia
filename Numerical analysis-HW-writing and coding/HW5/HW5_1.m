function HW5_1
Int_err = zeros(100);
y2 = zeros(100);
for N = 1: 100
    Int_err(N) = sim(N);
    y2(N) = 4^5*exp(4)/(2880*N^4);
end
plot(1:100, Int_err);
xlabel('N'); ylabel('err'); grid on;
figure;plot(1:100, y2);
xlabel('N'); ylabel('bound'); grid on;
end

function In_err = sim(N)
I = 0; 
for i = 0 : N-1
    a = 4*i/N; b = 4*(i+1)/N;
    I = I + (b-a)/(3*2)*(exp(a)+4*exp((a+b)/2)+exp(b));
end
In_err = abs(I - (exp(4)-1));
end