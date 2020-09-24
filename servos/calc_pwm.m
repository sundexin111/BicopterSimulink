function [servo_left,servo_right,motor_left,motor_right] = calc_pwm(roll_thrust,pitch_thrust,yaw_thrust,throttle_thrust)
%UNTITLED3 此处显示有关此函数的摘要
%   此处显示详细说明
thrust_left  = throttle_thrust + roll_thrust * 0.5;
thrust_right = throttle_thrust - roll_thrust * 0.5;

thrust_left = constrain(thrust_left,0,1);
thrust_right = constrain(thrust_right,0,1);

tilt_left  = pitch_thrust - yaw_thrust;
tilt_right = pitch_thrust + yaw_thrust;

tilt_left = constrain(tilt_left,-0.8,0.8);
tilt_right = constrain(tilt_right,-0.8,0.8);

servo_left = calc_pwm_servos(tilt_left  * 4500); 
servo_right = calc_pwm_servos(tilt_right * 4500); 
motor_left = calc_pwm_motors(thrust_left);
motor_right = calc_pwm_motors(thrust_right);
  
end

