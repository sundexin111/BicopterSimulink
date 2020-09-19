clear;clc;

%��������
global servos
servos=1000*ones(12,1);
%��������
%global state;
state=zeros(54,1);
global keytable;
keytable=["item","";                  %ң����8ͨ������
      "item","";
      "item","";
      "item","";
      "item","";
      "item","";
      "item","";
      "item","";
      "m-airspeed-MPS","";              %����(�����ǵ�λm/s)
      "m-altitudeASL-MTR","";
      "m-altitudeAGL-MTR","";
      "m-groundspeed-MPS","";           %����
      "m-pitchRate-DEGpSEC","";         %����������(DEGpSEC,��/s)
      "m-rollRate-DEGpSEC","";          %��ת������
      "m-yawRate-DEGpSEC","";           %ƫ��������
      "m-azimuth-DEG","";               %��λ��
      "m-inclination-DEG","";           %
      "m-roll-DEG","";                  %��ת��
      "m-aircraftPositionX-MTR","";     %X
      "m-aircraftPositionY-MTR","";     %Y
      "m-velocityWorldU-MPS","";        %�������ϵVx
      "m-velocityWorldV-MPS","";        %�������ϵVy
      "m-velocityWorldW-MPS","";        %�������ϵVz
      "m-velocityBodyU-MPS","";         %��������ϵU
      "m-velocityBodyV-MPS","";         %��������ϵV
      "m-velocityBodyW-MPS","";         %��������ϵW
      "m-accelerationWorldAX-MPS2","";  %�������ϵ���ٶ�ax��MPS2,��/s��
      "m-accelerationWorldAY-MPS2","";  %�������ϵ���ٶ�ay
      "m-accelerationWorldAZ-MPS2","";  %�������ϵ���ٶ�az
      "m-accelerationBodyAX-MPS2","";   %��������ϵ���ٶ�ax
      "m-accelerationBodyAY-MPS2","";   %��������ϵ���ٶ�ay
      "m-accelerationBodyAZ-MPS2","";   %��������ϵ���ٶ�az
      "m-windX-MPS","";
      "m-windY-MPS","";
      "m-windZ-MPS","";
      "m-propRPM","";
      "m-heliMainRotorRPM","";
      "m-batteryVoltage-VOLTS","";
      "m-batteryCurrentDraw-AMPS","";
      "m-batteryRemainingCapacity-MAH","";
      "m-fuelRemaining-OZ","";
      "m-isLocked","";                  %����״̬
      "m-hasLostComponents","";
      "m-anEngineIsRunning","";
      "m-isTouchingGround","";
      "m-currentAircraftStatus","";
      "m-currentPhysicsTime-SEC","";
      "m-currentPhysicsSpeedMultiplier","";
      "m-orientationQuaternion-X","";
      "m-orientationQuaternion-Y","";
      "m-orientationQuaternion-Z","";
      "m-orientationQuaternion-W","";
      "m-flightAxisControllerIsActive","";
      "m-resetButtonHasBeenPressed",""];

global controller_started;
controller_started=0;

%% ��ʱ��
 t = timer('TimerFcn',@t_bicoptersim,'Period',0.05,'ExecutionMode','fixedRate');
 start(t);

 while(1)
 end
 function t_bicoptersim(obj,event)

    tic
    %     servos(1,1)=servos(1,1)+5;
    %     servos(2,1)=servos(2,1)+5;
    %     servos(3,1)=servos(3,1)+10;
    %     servos(4,1)=servos(4,1)+5;

   %% ��realflight����ĸ�ͨ��������
    global servos
    state         = exchange_data(servos);
    pwm_roll      = rfsig_to_pwm(state(1));
    pwm_pitch     = rfsig_to_pwm(state(2));
    pwm_throttle  = rfsig_to_pwm(state(3));
    pwm_yaw       = rfsig_to_pwm(state(4));
    
    %��pwmת���ɽǶȻ�Χ
    angle_roll     = pwm_to_angle(pwm_roll);
    angle_pitch    = pwm_to_angle(pwm_pitch);
    angle_yaw      = pwm_to_angle(pwm_yaw);
    range_throttle = pwm_to_range(pwm_throttle);
    %% �����ʿ���
    [desired_rollrate,desired_pitchrate,desired_yawrate] = get_pilot_desired_angle_rates(angle_roll,angle_pitch,angle_yaw);
    %�������ʱ�׼������λ�ǣ�rad/s��
    desired_rollrate_rad = qianfendeg_to_rad(desired_rollrate);
    desired_pitchrate_rad = qianfendeg_to_rad(desired_pitchrate);
    desired_yawrate_rad = qianfendeg_to_rad(desired_yawrate);
    desired_throttle  = get_pilot_desired_throttle(range_throttle);
    
    actual_rollrate  = state(14);
    actual_pitchrate = state(13);
    actual_yawrate   = state(15);
    
    %[] = input_rate_bf_roll_pitch_yaw(desired_rollrate, desired_pitchrate, desired_pitchrate,actual_rollrate,actual_pitchrate,actual_yawrate);
    
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
   
   %% ��ʱ
   toc

 end