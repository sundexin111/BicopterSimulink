clear all;
close all;
clc


% %x=1;
% %t = timer('TimerFcn','disp(x);', 'Period', 1, 'ExecutionMode', 'fixedSpacing', 'TasksToExecute',10 );
% start(t)

% clear all;
% clc;
% 
% % ɾ�����еĶ�ʱ�������´���һ����ʱ��
% stop(timerfind);
% delete(timerfind);   
% timer_id = timer;
% %timer_id.StartDelay = 1.0;
% timer_id.Period = 1.0;
% % ������ִ��,fixedSpacingģʽ
% timer_id.ExecutionMode = 'fixedSpacing';
% timer_id.TimerFcn = @test_bicoptersim;
% %������ʱ��
% start(timer_id);

% function timer_handler(~,~)
%     persistent counter;
%     if isempty(counter)
%      counter = 0;
%     end
%     fprintf(1,'��ʱ���ص�=%d\n',counter);
%     counter = counter+1;
% end