function rate_target_ang_vel = attitude_controller_run_quat(tar_q,actual_roll,actual_pitch,actual_yaw)
global q
%UNTITLED3 此处显示有关此函数的摘要
%   此处显示详细说明
%计算姿态误差
%求出实际姿态角的四元数
[act_q] = euler_to_quad(actual_roll,actual_pitch,actual_yaw);

%倾转分离算法,得到姿态误差矢量
attitude_error_vector = thrust_heading_rotation_angles(tar_q,act_q);

%由姿态误差计算期望角速率
rate_target_ang_vel = update_ang_vel_target_from_att_error(attitude_error_vector);

%不加任何前馈
%每次执行完确保四元数是单位化的
%[tar_q(1),tar_q(2),tar_q(3),tar_q(4)] = norm(tar_q(1),tar_q(2),tar_q(3),tar_q(4));
quatMag  = sqrt(tar_q(1)*tar_q(1)+tar_q(2)*tar_q(2)+tar_q(3)*tar_q(3)+tar_q(4)*tar_q(4));
if(quatMag ~= 0)
    quatMagInv = 1/quatMag;
    tar_q(1) = tar_q(1) * quatMagInv;
    tar_q(2) = tar_q(2) * quatMagInv;
    tar_q(3) = tar_q(3) * quatMagInv;
    tar_q(4) = tar_q(4) * quatMagInv;
    q(1) = tar_q(1);
    q(2) = tar_q(2);
    q(3) = tar_q(3);
    q(4) = tar_q(4);
end
    
end

