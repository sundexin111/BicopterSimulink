function yaw_in = set_yaw(desired_yawrate,actual_yawrate)
%UNTITLED4 此处显示有关此函数的摘要
%   此处显示详细说明
yaw_rate.kp = 0.2;
yaw_rate.ki = 0.01;
yaw_rate.kd = 0.001;
kimax = 0.5;
dt=0.05;

error = 0;
error_last = error;
error = desired_yawrate - actual_yawrate;
derivative = (error - error_last)/dt;

integrator = error * yaw_rate.ki * dt;
integrator = constrain(integrator,-kimax,kimax);


P_out = error * yaw_rate.kp;
I_out = integrator;
D_out = derivative * yaw_rate.kd;

yaw_in = P_out + I_out + D_out;
end

