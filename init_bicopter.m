%% 存放初值
%四元数
global q dt DEG_TO_RAD ROLL_PITCH_YAW_INPUT_MAX acro_rp_expo acro_rp_p acro_y_expo acro_yaw_p roll_rate_kp roll_rate_ki roll_rate_kd pitch_rate_kp pitch_rate_ki pitch_rate_kd ...
yaw_rate_kp yaw_rate_ki yaw_rate_kd kimax p_angle_roll_kp p_angle_pitch_kp p_angle_yaw_kp

%四元数
q(1) = 1;
q(2) = 0;
q(3) = 0;
q(4) = 0;

%时间
dt = 0.05;

DEG_TO_RAD = 3.141592653589793/180;
%arco模式
ROLL_PITCH_YAW_INPUT_MAX = 4500;
acro_rp_expo = 0.3;
acro_rp_p = 4.5;
acro_y_expo = 4.5;
acro_yaw_p  = 4.5;

%% pid参数
%姿态环
p_angle_roll_kp  = 0.4;
p_angle_pitch_kp = 0.4;
p_angle_yaw_kp   = 0.4;
%速率换
roll_rate_kp = 0.2;
roll_rate_ki = 0.01;
roll_rate_kd = 0.001;
kimax = 0.5;

pitch_rate_kp = 0.2;
pitch_rate_ki = 0.01;
pitch_rate_kd = 0.001;

yaw_rate_kp = 0.2;
yaw_rate_ki = 0.01;
yaw_rate_kd = 0.001;
