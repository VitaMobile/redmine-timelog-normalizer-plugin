class TimelogNormalizerMailer < ActionMailer::Base
  def timelog_fixed(user)
    body :body => preset("fix", user.mail)
  end

  def timelog_remind(user)
    body :body => preset("remind", user.mail)
  end

  def method_missing(method_symbol, *parameters)#:nodoc:
    case method_symbol.id2name
    when /^create_([_a-z]\w*)/ then new($1, *parameters).mail
    when /^deliver_([_a-z]\w*)/ then new($1, *parameters).deliver!
    when "new" then nil
    else super
    end
  end

  def preset(mode, mail)
    from Setting.mail_from
    recipients mail
    content_type "text/html"
    subject Setting.plugin_redmine_timelog_normalizer["mail_" + mode + "_subject"].to_s
    sent_on Time.now
    return Setting.plugin_redmine_timelog_normalizer["mail_" + mode + "_body"].to_s
  end
end

