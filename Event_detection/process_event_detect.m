function process_event_detect(filename_h)
f_mat = dir([filename_h '*.mat']);
for i =1:length(f_mat)
    clearvars S event_index amps poi
     S = load(f_mat(i).name);
    if strcmp(S.type{1},'EPSC')
        amp_thre = 6; diff_gap = 240; diff_thre =-8;if_2der=1;event_duration = 640;
        [event_index,amps] = EPSC_detection(S.Data(:,1),S.si,amp_thre,if_2der,diff_gap,diff_thre,event_duration);
        save(f_mat(i).name,'event_index','amps','-append');
    end
    if strcmp(S.type{1},'EPSP')
        amp_thre = 3; diff_gap = 140; diff_thre =6;if_2der=0;event_duration =1200;
        [event_index,amps] = EPSC_detection(S.Data(:,1),S.si,amp_thre,if_2der,diff_gap,diff_thre,event_duration);
        save(f_mat(i).name,'event_index','amps','-append');
    end
end
end