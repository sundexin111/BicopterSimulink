function angle = pwm_to_angle(radio_in)
%需要两个参数，地面站给的 _dead_zone,radio_trim 
radio_min  = 1100;
radio_max  = 1900;
%dead_zone   = 30;
radio_trim = 1500;
radio_min = 1100;

%radio_trim_high = radio_trim + dead_zone;
%radio_trim_low  = radio_trim - dead_zone;


%if (radio_in > radio_trim_high && radio_max ~= radio_trim_high)
if (radio_in > radio_trim )
   %angle =  (radio_in - radio_trim) / (radio_max  - radio_trim);
   %arco用
   angle =  (radio_in - radio_trim) / (radio_max  - radio_trim) * 4500;
else
   %angle =  (radio_in - radio_trim) / (radio_trim - radio_min);   
   %arco用
   angle =  (radio_in - radio_trim) / (radio_trim - radio_min) * 4500;
end
end

