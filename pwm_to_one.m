function [roll_thrust,pitch_thrust,yaw_thrust,throttle_thrust] = pwm_to_one(stick_roll,stick_pitch,stick_yaw,stick_throttle)
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
roll_in = pwm_to_angle(stick_roll);
pitch_in = pwm_to_angle(stick_pitch);
yaw_in = pwm_to_angle(stick_yaw);
throttle_in = pwm_to_range(stick_throttle);

roll_in = constrain(roll_in,-1,1);
pitch_in = constrain(pitch_in,-1,1);
yaw_in = constrain(yaw_in,-1,1);
throttle_in = constrain(throttle_in,0,1);

roll_thrust = roll_in;
pitch_thrust = pitch_in;
yaw_thrust = yaw_in;
throttle_thrust = throttle_in;
end

