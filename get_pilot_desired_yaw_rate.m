function yaw_request = get_pilot_desired_yaw_rate(stick_angle)
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
acro_y_expo = 4.5;
acro_yaw_p  = 4.5;
ROLL_PITCH_YAW_INPUT_MAX = 4500;

   if (acro_y_expo <= 0)
        yaw_request = stick_angle * acro_yaw_p;
   else
        %expo variables
        %range check expo
        if (acro_y_expo > 1 || acro_y_expo < 0.5) 
            acro_y_expo = 1;
        end

        %yaw expo
        y_in = (stick_angle)/ROLL_PITCH_YAW_INPUT_MAX;
        y_in3 = y_in*y_in*y_in;
        y_out = (acro_y_expo * y_in3) + ((1 - acro_y_expo) * y_in);
        yaw_request = ROLL_PITCH_YAW_INPUT_MAX * y_out * acro_yaw_p;
   end
end

