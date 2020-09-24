function input_rate_bf_roll_pitch_yaw(roll_rate_bf_cds, pitch_rate_bf_cds,yaw_rate_bf_cds)
global q DEG_TO_RAD dt

%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
%将角度转化成弧度
%DEG_TO_RAD = 3.141592653589793/180;
%dt = 0.05;

roll_rate_rads  = roll_rate_bf_cds   * DEG_TO_RAD * 0.01;
pitch_rate_rads = pitch_rate_bf_cds  * DEG_TO_RAD * 0.01 ;
yaw_rate_rads   = yaw_rate_bf_cds    * DEG_TO_RAD * 0.01;

%[roll,pitch,yaw] = quat_to_euler(q);

%无前馈
%根据期望角速率得到的四元数
up_q = attitude_target_update_quat_from_axis_angle(roll_rate_rads * dt,pitch_rate_rads * dt,yaw_rate_rads * dt);
%四元数更新
q = quat_dot(q,up_q);
q(1) = q(1) * up_q(1);
q(2) = q(2) * up_q(2);
q(3) = q(3) * up_q(3);
q(4) = q(4) * up_q(4);

%下面是将期望姿态角的四元数标准化
q = Q_normalize(q);
end

