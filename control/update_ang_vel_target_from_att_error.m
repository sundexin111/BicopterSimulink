function rate_target_ang_vel = update_ang_vel_target_from_att_error(attitude_error_rot_vec_rad)
%UNTITLED8 此处显示有关此函数的摘要
%   此处显示详细说明
%不使用开平方控制器
global p_angle_roll_kp p_angle_pitch_kp p_angle_yaw_kp

error_roll_rad  = attitude_error_rot_vec_rad(1);
error_pitch_rad = attitude_error_rot_vec_rad(2);
error_yaw_rad   = attitude_error_rot_vec_rad(3);

rate_target_ang_vel(1) = p_angle_roll_kp  * error_roll_rad;
rate_target_ang_vel(2) = p_angle_pitch_kp * error_pitch_rad;
rate_target_ang_vel(3) = p_angle_yaw_kp   * error_yaw_rad;
end

