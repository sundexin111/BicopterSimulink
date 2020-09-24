function q = euler_to_quad(roll,pitch,yaw)
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
cr2 = cos(roll*0.5);
cp2 = cos(pitch*0.5);
cy2 = cos(yaw*0.5);
sr2 = sin(roll*0.5);
sp2 = sin(pitch*0.5);
sy2 = sin(yaw*0.5);

q(1) = cr2*cp2*cy2 + sr2*sp2*sy2;
q(2) = sr2*cp2*cy2 - cr2*sp2*sy2;
q(3) = cr2*sp2*cy2 + sr2*cp2*sy2;
q(4) = cr2*cp2*sy2 - sr2*sp2*cy2;
end

