function q = from_axis_angle(axis,theta)
%UNTITLED5 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
if(theta == 0)
    q(1)=1;
    q(2)=0;
    q(3)=0;
    q(4)=0;
else
    st2 = sin(theta/2);
    q(1) = cos(theta/2);
    q(2) = axis(1) * st2;
    q(3) = axis(2) * st2;
    q(4) = axis(3) * st2;
end
end

