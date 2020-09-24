function throttle_out = get_pilot_desired_throttle(range_throttle)
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
AP_MOTORS_THST_HOVER_DEFAULT = 0.35;

thr_mid = AP_MOTORS_THST_HOVER_DEFAULT;
throttle_control = range_throttle;
mid_stick = 500;
throttle_control = constrain(throttle_control,0,1000);

%计算线性油门输出
if(throttle_control < mid_stick)
    throttle_in = throttle_control * 0.5/ mid_stick;
else
    throttle_in = 0.5 + (throttle_control - mid_stick) * 0.5/(1000-mid_stick);
end
expo = constrain(-(thr_mid - 0.5)/0.375,-0.5,1);
throttle_out = throttle_in *(1-expo) + expo * throttle_in * throttle_in * throttle_in;
end

