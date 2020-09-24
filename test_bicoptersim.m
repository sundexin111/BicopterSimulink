clear all;
close all;
clc
init_bicopter
global servos q
servos=1000*ones(12,1);
%% 定时器

 %t = timer('TimerFcn',@t_bicoptersim,'Period',0.0025,'ExecutionMode','fixedRate','TasksToExecute',Inf);
 %start(t);

 
 %while(1)
%    desired_rollrate = 0;
%    actual_rollrate = 0;
%    desired_pitchrate = 3;
%    actual_pitchrate = 0.5;
%    desired_yawrate = 0;
%    actual_yawrate = 0;
%    desired_throttle = 0.5;
stick_roll     = 1500;
stick_pitch    = 1600;
stick_yaw      = 1500;
stick_throttle = 1500;
angle_roll = pwm_to_angle(stick_roll);
angle_pitch = pwm_to_angle(stick_pitch);
angle_yaw = pwm_to_angle(stick_yaw);
range_throttle = pwm_to_range(stick_throttle);

    %% 角速率控制
    [rollrate_stick,pitchrate_stick,yawrate_stick] = get_pilot_desired_angle_rates(angle_roll,angle_pitch,angle_yaw);
    %将角速率标准化，单位是（rad/s）
%     rollrate_stick_rad  = radians(rollrate_stick);
%     pitchrate_stick_rad = radians(pitchrate_stick);
%     yawrate_stick_rad   = radians(yawrate_stick);
    desired_throttle    = get_pilot_desired_throttle(range_throttle);

%     [desired_rollrate,desired_pitchrate,desired_yawrate] = get_pilot_desired_angle_rates(roll,pitch,yaw);
%     desired_rollrate_rad  = qianfendeg_to_rad(desired_rollrate);
%     desired_pitchrate_rad = qianfendeg_to_rad(desired_pitchrate);
%     desired_yawrate_rad   = qianfendeg_to_rad(desired_yawrate);
%     desired_throttle      = get_pilot_desired_throttle(throttle);

    actual_roll      = 0;
    actual_pitch     = 3;
    actual_yaw       = 0;
   
    actual_rollrate  = 0;
    actual_pitchrate = 0.5;
    actual_yawrate   = 0;
    
   input_rate_bf_roll_pitch_yaw(rollrate_stick,pitchrate_stick,yawrate_stick);
    
    %根据四元数以及实际姿态角求期望姿态角速率
    desired_attituderate_rad  = attitude_controller_run_quat(q,actual_roll,actual_pitch,actual_yaw);
    desired_rollrate_rad      = desired_attituderate_rad(1);
    desired_pitchrate_rad     = desired_attituderate_rad(2);
    desired_yawrate_rad       = desired_attituderate_rad(3);

    roll_in     = set_roll(desired_rollrate_rad,actual_rollrate);
    pitch_in    = set_pitch(desired_pitchrate_rad,actual_pitchrate);
    yaw_in      = set_yaw(desired_yawrate_rad,actual_yawrate);
    throttle_in = desired_throttle;
    
    %% 将遥控器信号转化成thrust;
    [roll_thrust,pitch_thrust,yaw_thrust,throttle_thrust] = get_thrust(roll_in,pitch_in,yaw_in,throttle_in);

   %% 将遥控器输入范围限制在（-1，1）或者（0-1）
   %[roll_thrust,pitch_thrust,yaw_thrust,throttle_thrust] = pwm_to_one(stick_roll,stick_pitch,stick_yaw,stick_throttle);

   %% 舵机分配
   [servo_left,servo_right,motor_left,motor_right] = calc_pwm(roll_thrust,pitch_thrust,yaw_thrust,throttle_thrust);
   servos = [1000 ;1000;1500;1000;motor_right;motor_left;servo_left;servo_right;1000;1000;1000;1000];   
% end



%global servos
    %global servos
    %     servos(1,1)=servos(1,1)+5;
    %     servos(2,1)=servos(2,1)+5;
    %     servos(3,1)=servos(3,1)+10;
    %     servos(4,1)=servos(4,1)+5;
   %% 从realflight获得四个通道的输入
    %state      = exchange_data(servos);

    %% 遥控器信号输入

%     stick_roll      = 1700;
%     stick_pitch     = 1500;
%     stick_throttle  = 1500;
%     stick_yaw       = 1500;


