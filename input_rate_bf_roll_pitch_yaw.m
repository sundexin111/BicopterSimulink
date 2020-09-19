function [q1,q2,q3,q4] = input_rate_bf_roll_pitch_yaw(roll_rate_bf_cds, pitch_rate_bf_cds,yaw_rate_bf_cds,actual_rollrate,actual_pitchrate,actual_yawrate)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
%将角度转化成弧度
DEG_TO_RAD = 3.141592653589793/180;
dt = 0.05;

roll_rate_rads  = roll_rate_bf_cds   * DEG_TO_RAD * 0.01;
pitch_rate_rads = pitch_rate_bf_cds  * DEG_TO_RAD * 0.01 ;
yaw_rate_rads   = yaw_rate_bf_cds    * DEG_TO_RAD * 0.01;

[roll,pitch,yaw] = quat_to_euler(q1,q2,q3,q4);
%无前馈
[tar_q1,tar_q2,tar_q3,tar_q4]= ;
[up_q1,up_q2,up_q3,up_q4] = attitude_target_update_quat_from_axis_angle(roll_rate_rads * dt,pitch_rate_rads * dt,yaw_rate_rads * dt);
[tar_q1,tar_q2,tar_q3,tar_q4] = [tar_q1,tar_q2,tar_q3,tar_q4] * [up_q1,up_q2,up_q3,up_q4]';
quatMag  = sqrt(q1*q1+q2*q2+q3*q3+q4*q4);
if(quatMag != 0)
    quatMagInv = 1/quatMag;
    q1 = q1 * quatMagInv;
    q2 = q2 * quatMagInv;
    q3 = q3 * quatMagInv;
    q4 = q4 * quatMagInv;
end
attitude_controller_run_quat(q1,q2,q3,q4,actual_rollrate,actual_pitchrate,actual_yawrate);

end

