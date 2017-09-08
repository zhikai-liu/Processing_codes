function process_plot_fit(filename_h)
f_abf = dir([filename_h '*.mat']);
for i =1:length(f_abf)
    clearvars S cycle_index amps_cycle
    S = load(f_abf(i).name);
    for j =1:length(S.poi)
        clearvars poi
        poi_start = S.poi{j}(1)*1e6/S.si;
        poi_end = S.poi{j}(end)*1e6/S.si;
        poi = poi_start+1:poi_end;
        F1 = figure;
        plot_accel_fit(S.Data,poi,S.fit_model{j},S.S_period{j},S.accel_axis,S.si,S.type);
        title(F1.Children(end),[S.name ' Period ' num2str(j) ' of ' num2str(length(S.poi))],'interpreter','none');
        print([S.name '_period_' num2str(j) '_raw_fit.pdf'],'-fillpage','-dpdf');
        F2 = figure;
        if isfield(S,'event_index')
            plot_cycle_fit(S.Data,S.event_index,S.amps,poi,S.fit_model{j},S.S_period{j},S.type);
        else
            plot_cycle_fit(S.Data,[],[],poi,S.fit_model{j},S.S_period{j},S.type);
        end
        title(F2.Children(2),{[S.name ' (Period ' num2str(j) ')'], [' Sin: Freq ' num2str(S.fit_freq{j}) '  Amp ' num2str(S.fit_amp{j}) 'g']},'interpreter','none');
        print([S.name '_period_' num2str(j) '_cycle_fit.pdf'],'-fillpage','-dpdf');
    end
end
