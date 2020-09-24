function limit_a = constrain(a,b,c)
%UNTITLED5 此处显示有关此函数的摘要
%   此处显示详细说明
if(a<b)
    limit_a = b;
elseif(a>c)
    limit_a = c;
else
    limit_a = a;
end

