function axis_angle = to_axis_angle(q)
%UNTITLED6 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
l = sqrt(q(2)^2 + q(3)^2 + q(4)^2);
v = [q(2),q(3),q(4)]';
if(l ~= 0)
    v = v / l;
    v =v* 2.0 * atan2(l,q(1));
end
axis_angle = v;
end

