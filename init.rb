require 'redmine'

require_dependency 'timelog_normalizer_user_patch'

Redmine::Plugin.register :redmine_timelog_normalizer do
  name 'Redmine Timelog Normalizer plugin'
  author 'Vita Mobile Company'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'http://github.com/VitaMobile/redmine-timelog-normalizer-plugin'
  author_url 'http://vita-mobile.com'

  settings(:partial => 'settings/normalizer_settings',
           :default => {
             'threshold' => 3,
             'quota' => 40,
             'mail_fix_subject' => 'mail subject',
             'mail_fix_body' => 'mail body',
             'mail_remind_subject' => 'mail subject',
             'mail_remind_body' => 'mail body'
           }) 

  menu(:top_menu,
       :timelog_normalize, {
         :controller => 'timelog_normalizer',
         :action => 'index'
       },
       :caption => 'Timelog Normalizer Users',
       :if => Proc.new{ User.current.admin })
end
