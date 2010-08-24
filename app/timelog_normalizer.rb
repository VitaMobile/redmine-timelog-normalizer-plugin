threshold, quota = Setting.plugin_redmine_timelog_normalizer["threshold"].to_f,
  Setting.plugin_redmine_timelog_normalizer["quota"].to_f

User.all(:joins => :timelog_normalizer_user).each do |user|
  entries = user.prev_week_entries
  hours = entries.map{ |entry| entry.hours }.
    reduce{ |a, b| a + b }.to_f

  if hours < quota
    if (quota - hours).abs <= threshold
      ratio = quota / hours
      entries.each do |entry|
        entry.hours = sprintf("%.2f", entry.hours * ratio).to_f
        entry.save
      end
      TimelogNormalizerMailer.deliver_timelog_fixed user      
    else
      TimelogNormalizerMailer.deliver_timelog_remind user
    end
  end
  
end
