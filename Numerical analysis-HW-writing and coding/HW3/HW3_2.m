function [Iy1, Iy2, Iy3]=HW3_2(t)
%% f
[output_f, output_p, ~, P_2] = HW3_1(t, 0);
% f = @(x)((6*x.^4+4*x.^2-2)./((1+x.^2).^4));
% f = @(x)(1./(1+x.^2));
x = -5:t:5; 
dy = diff(output_f)/t;
ddy = diff(dy)/t;
Iy1 = sum(ddy.^2 * t);
clear output_f dy ddy

%% p
% [~, ~, output] = HW2_5(t);
dy = diff(output_p)/t;
ddy = diff(dy)/t;
Iy2 = sum(ddy.^2 * t);
clear output_p dy ddy

%% s 
Iy3 = 0;
for i = 1 : 10
    x = -6+i:t:-5+i; y = P_2(x, i);
    dy = diff(y)/t;
    ddy = diff(dy)/t;
    Iy3 = Iy3+sum(ddy.^2 * t);
end

end