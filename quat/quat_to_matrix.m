function rotation_matrix = quat_to_matrix(q)
%UNTITLED4 此处显示有关此函数的摘要
%   此处显示详细说明
    q3q3 = q(3) * q(3);
    q3q4 = q(3) * q(4);
    q2q2 = q(2) * q(2);
    q2q3 = q(2) * q(3);
    q2q4 = q(2) * q(4);
    q1q2 = q(1) * q(2);
    q1q3 = q(1) * q(3);
    q1q4 = q(1) * q(4);
    q4q4 = q(4) * q(4);

    ax = 1-2*(q3q3 + q4q4);
    ay = 2*(q2q3 - q1q4);
    az = 2*(q2q4 + q1q3);
    bx = 2*(q2q3 + q1q4);
    by = 1-2*(q2q2 + q4q4);
    bz = 2*(q3q4 - q1q2);
    cx = 2*(q2q4 - q1q3);
    cy = 2*(q3q4 + q1q2);
    cz = 1-2*(q2q2 + q3q3);
    rotation_matrix = [ax,ay,az;bx,by,bz;cx,cy,cz];
end


