function ret = norm_input(radio_in)
%UNTITLED4 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
radio_min  = 1100;
radio_max  = 1900;
radio_trim = 1500;

if (radio_in < radio_trim)
    if (radio_min >= radio_trim)
        ret = 0;
    end
    ret =  (radio_in - radio_trim) / (radio_trim - radio_min);
else
    if (radio_max <= radio_trim)
        ret = 0;
    end
    ret = (radio_in - radio_trim) / (radio_max  - radio_trim);
end
ret = constrain(ret,-1,1);

end

