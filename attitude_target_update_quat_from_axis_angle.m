function [q1,q2,q3,q4] = attitude_target_update_quat_from_axis_angle(v_x,v_y,v_z)
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
theta = sqrt(v_x * v_x,v_y*v_y,v_z*v_z);
if(theta == 0)
    q1=1; q2=0;q3=0;q4=0;
else
    v_x = v_x/theta;
    v_y = v_y/theta;
    v_z = v_z/theta;
    st2 = sin(theta/2);
    q1 = cos(theta/2);
    q2 = v_x * st2;
    q3 = v_y * st2;
    q4 = v_z * st2;
end
end

