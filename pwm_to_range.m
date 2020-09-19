function range = pwm_to_range(radio_in)
%UNTITLED9 此处显示有关此函数的摘要
%   此处显示详细说明
radio_min = 1100;
radio_max = 1900;
high_in   = 1000;

range = (radio_in - radio_min) / (radio_max - radio_min) * high_in;

end

