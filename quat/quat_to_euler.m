function [roll,pitch,yaw] = quat_to_euler(q)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
roll  = atan2(2*(q(1)*q(2)+q(3)*q(4)),(1-2*(q(2)*q(2)+q(3)*q(3))));
pitch = asin(2*(q(1)*q(3)-q(4)*q(2)));
yaw   = atan2(2*(q(1)*q(4)+q(2)*q(3)),(1-2*(q(3)*q(3)+q(4)*q(4))));
end

