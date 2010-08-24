class TimelogNormalizerUser < ActiveRecord::Base
  unloadable

  belongs_to :user
end
