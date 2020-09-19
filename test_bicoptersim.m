clear all;
close all;
clc
global servos
servos=1000*ones(12,1);
%% ��ʱ��

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
stick_roll     = 1900;
stick_pitch    = 1500;
stick_yaw      = 1500;
stick_throttle = 1900;
roll = pwm_to_angle(stick_roll);
pitch = pwm_to_angle(stick_pitch);
yaw = pwm_to_angle(stick_yaw);
throttle = pwm_to_range(stick_throttle);

    %% �����ʿ���
    [desired_rollrate,desired_pitchrate,desired_yawrate] = get_pilot_desired_angle_rates(roll,pitch,yaw);
    desired_rollrate_rad  = qianfendeg_to_rad(desired_rollrate);
    desired_pitchrate_rad = qianfendeg_to_rad(desired_pitchrate);
    desired_yawrate_rad   = qianfendeg_to_rad(desired_yawrate);
    desired_throttle      = get_pilot_desired_throttle(throttle);
    
    actual_rollrate  = 0;
    actual_pitchrate = 0.5;
    actual_yawrate   = 0;

    roll_in     = set_roll(desired_rollrate_rad,actual_rollrate);
    pitch_in    = set_pitch(desired_pitchrate_rad,actual_pitchrate);
    yaw_in      = set_yaw(desired_yawrate_rad,actual_yawrate);
    throttle_in = desired_throttle;
    
    %% ��ң�����ź�ת����thrust;
    [roll_thrust,pitch_thrust,yaw_thrust,throttle_thrust] = get_thrust(roll_in,pitch_in,yaw_in,throttle_in);

   %% ��ң�������뷶Χ�����ڣ�-1��1�����ߣ�0-1��
   %[roll_thrust,pitch_thrust,yaw_thrust,throttle_thrust] = pwm_to_one(stick_roll,stick_pitch,stick_yaw,stick_throttle);

   %% �������
   [servo_left,servo_right,motor_left,motor_right] = calc_pwm(roll_thrust,pitch_thrust,yaw_thrust,throttle_thrust);
   servos = [1000 ;1000;1500;1000;motor_right;motor_left;servo_left;servo_right;1000;1000;1000;1000];   
% end



%global servos
    %global servos
    %     servos(1,1)=servos(1,1)+5;
    %     servos(2,1)=servos(2,1)+5;
    %     servos(3,1)=servos(3,1)+10;
    %     servos(4,1)=servos(4,1)+5;
   %% ��realflight����ĸ�ͨ��������
    %state      = exchange_data(servos);

    %% ң�����ź�����

%     stick_roll      = 1700;
%     stick_pitch     = 1500;
%     stick_throttle  = 1500;
%     stick_yaw       = 1500;


