function q = quat_dot(q1,q2)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
q(1) = q1(1) * q2(1) - q1(2) * q2(2) - q1(3) * q2(3) - q1(4) * q2(4);
q(2) = q1(2) * q2(1) + q1(1) * q2(2) - q1(4) * q2(3) + q1(3) * q2(4);
q(3) = q1(3) * q2(1) + q1(4) * q2(2) + q1(1) * q2(3) - q1(2) * q2(4);
q(4) = q1(4) * q2(1) - q1(3) * q2(2) + q1(2) * q2(3) + q1(1) * q2(4);
end

