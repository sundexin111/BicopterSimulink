function roll_in = set_roll(desired_rollrate,actual_rollrate)
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
roll_rate.kp = 0.2;
roll_rate.ki = 0.01;
roll_rate.kd = 0.001;
kimax = 0.5;
dt=0.05;

error = 0;
error_last = error;
error = desired_rollrate - actual_rollrate;
derivative = (error - error_last)/dt;

integrator = error * roll_rate.ki * dt;
integrator = constrain(integrator,-kimax,kimax);

P_out = error * roll_rate.kp;
I_out = integrator;
D_out = derivative * roll_rate.kd;

roll_in = P_out + I_out + D_out;

end

