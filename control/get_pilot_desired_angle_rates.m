function [target_roll_rate,target_pitch_rate,target_yaw_rate] = get_pilot_desired_angle_rates(roll_in,pitch_in,yaw_in)
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
global ROLL_PITCH_YAW_INPUT_MAX acro_rp_expo acro_rp_p
% ROLL_PITCH_YAW_INPUT_MAX = 4500;
% acro_rp_expo = 0.3;
% acro_rp_p = 4.5;

%total_in = norm(roll_in,pitch_in);
total_in = sqrt(roll_in * roll_in + pitch_in * pitch_in);
if(total_in > ROLL_PITCH_YAW_INPUT_MAX)
    ratio = ROLL_PITCH_YAW_INPUT_MAX / total_in;
    roll_in  = roll_in * ratio;
    pitch_in = pitch_in * ratio;
end
%���㸩������ת��������
if(acro_rp_expo <=0)
    roll_rate_request  =  roll_in * acro_rp_p;
    pitch_rate_request = pitch_in * acro_rp_p;
else
    if(acro_rp_expo > 1)
        acro_rp_expo = 1;
    end
    %roll expo
    rp_in = (roll_in)/ROLL_PITCH_YAW_INPUT_MAX;
    rp_in3 = rp_in*rp_in*rp_in;
    rp_out = (acro_rp_expo * rp_in3) + ((1 - acro_rp_expo) * rp_in);
    roll_rate_request = ROLL_PITCH_YAW_INPUT_MAX * rp_out * acro_rp_p;
    
    %pitch expo
    rp_in = (pitch_in)/ROLL_PITCH_YAW_INPUT_MAX;
    rp_in3 = rp_in*rp_in*rp_in;
    rp_out = (acro_rp_expo * rp_in3) + ((1 - acro_rp_expo) * rp_in);
    pitch_rate_request = ROLL_PITCH_YAW_INPUT_MAX * rp_out * acro_rp_p;
    
    %yaw expo
    yaw_rate_request = get_pilot_desired_yaw_rate(yaw_in);
    
    % arco_trainer disabled
    target_roll_rate  = roll_rate_request;
    target_pitch_rate = pitch_rate_request;
    target_yaw_rate   = yaw_rate_request;
end

