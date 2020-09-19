clear all;
close all;
clc


% %x=1;
% %t = timer('TimerFcn','disp(x);', 'Period', 1, 'ExecutionMode', 'fixedSpacing', 'TasksToExecute',10 );
% start(t)

% clear all;
% clc;
% 
% % 删除现有的定时器，重新创建一个定时器
% stop(timerfind);
% delete(timerfind);   
% timer_id = timer;
% %timer_id.StartDelay = 1.0;
% timer_id.Period = 1.0;
% % 周期性执行,fixedSpacing模式
% timer_id.ExecutionMode = 'fixedSpacing';
% timer_id.TimerFcn = @test_bicoptersim;
% %启动定时器
% start(timer_id);

% function timer_handler(~,~)
%     persistent counter;
%     if isempty(counter)
%      counter = 0;
%     end
%     fprintf(1,'定时器回调=%d\n',counter);
%     counter = counter+1;
% end