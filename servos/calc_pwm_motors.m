function pwm_motors = calc_pwm_motors(thrust_throttle)
servo_min  = 1100;
servo_max  = 1900;

%UNTITLED3 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
    pwm_motors = servo_min + thrust_throttle * (servo_max - servo_min);
end

