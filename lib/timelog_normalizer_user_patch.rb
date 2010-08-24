require_dependency 'principal'
require_dependency 'user'

module TimelogNormalizerUserPatch
  def prev_week_entries
    now, sec_in_day = Time.now, 86400
    today = Time.local(now.year, now.month, now.day, 0, 0, 0)
    begin_prev_week = today - ((today.wday + 6) * sec_in_day)
    end_prev_week = begin_prev_week + 5 * sec_in_day

    entries = TimeEntry.all(:conditions =>
                            ["spent_on BETWEEN :from AND :to AND user_id = :user_id", {
                               :from => begin_prev_week.to_date.to_s,
                               :to => end_prev_week.to_date.to_s,
                               :user_id => self.id}])
    return entries
  end

  def timelog_normalizer_enable
    TimelogNormalizerUser.create(:user => self)
  end

  def timelog_normalizer_enable?
    return self.timelog_normalizer_user ? true : false
  end
  
end

User.send(:include, TimelogNormalizerUserPatch)
User.has_one :timelog_normalizer_user, :dependent => :destroy

