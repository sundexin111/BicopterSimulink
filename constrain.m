function limit_a = constrain(a,b,c)
%UNTITLED5 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
if(a<b)
    limit_a = b;
elseif(a>c)
    limit_a = c;
else
    limit_a = a;
end

