function pitch_in = set_pitch(desired_rollrate,actual_rollrate)
%UNTITLED3 此处显示有关此函数的摘要
%   此处显示详细说明
global pitch_rate_kp pitch_rate_ki pitch_rate_kd kimax dt
% pitch_rate_kp = 0.2;
% pitch_rate_ki = 0.01;
% pitch_rate_kd = 0.001;
% kimax = 0.5;
% dt=0.05;

error = 0;
error_last = error;
error = desired_rollrate - actual_rollrate;
derivative = (error - error_last)/dt;

integrator = error * pitch_rate_ki * dt;
integrator = constrain(integrator,-kimax,kimax);


P_out = error * pitch_rate_kp;
I_out = integrator;
D_out = derivative * pitch_rate_kd;

pitch_in = P_out + I_out + D_out;
end

