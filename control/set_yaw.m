function yaw_in = set_yaw(desired_yawrate,actual_yawrate)
%UNTITLED4 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
global yaw_rate_kp yaw_rate_ki yaw_rate_kd kimax dt
% yaw_rate_kp = 0.2;
% yaw_rate_ki = 0.01;
% yaw_rate_kd = 0.001;
% kimax = 0.5;
% dt=0.05;

error = 0;
error_last = error;
error = desired_yawrate - actual_yawrate;
derivative = (error - error_last)/dt;

integrator = error * yaw_rate_ki * dt;
integrator = constrain(integrator,-kimax,kimax);


P_out = error * yaw_rate_kp;
I_out = integrator;
D_out = derivative * yaw_rate_kd;

yaw_in = P_out + I_out + D_out;
end

