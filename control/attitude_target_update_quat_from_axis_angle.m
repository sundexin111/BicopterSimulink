function q = attitude_target_update_quat_from_axis_angle(v_x,v_y,v_z)
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
theta = sqrt(v_x * v_x+v_y*v_y+v_z*v_z);
if(theta == 0)
    q(1)=1; q(2)=0;q(3)=0;q(4)=0;
else
    v_x = v_x/theta;
    v_y = v_y/theta;
    v_z = v_z/theta;
    st2 = sin(theta/2);
    q(1) = cos(theta/2);
    q(2) = v_x * st2;
    q(3) = v_y * st2;
    q(4) = v_z * st2;
end
end

