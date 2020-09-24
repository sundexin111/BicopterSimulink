function pwm_servos  = calc_pwm_servos(scaled_value)
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
servo_trim = 1500;
servo_min  = 1100;
servo_max  = 1900;
high_out_angle = 4500;

scaled_value = constrain(scaled_value,-high_out_angle,high_out_angle);
if (scaled_value > 0)
    pwm_servos = servo_trim + scaled_value * (servo_max - servo_trim) / high_out_angle;
else
    pwm_servos = servo_trim + (-scaled_value) * (servo_trim - servo_min) / high_out_angle;
end

end

