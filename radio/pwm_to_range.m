function range = pwm_to_range(radio_in)
%UNTITLED9 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
radio_min = 1100;
radio_max = 1900;
high_in   = 1000;

range = (radio_in - radio_min) / (radio_max - radio_min) * high_in;

end

