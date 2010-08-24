class TimelogNormalizerController < ApplicationController
  unloadable

  def index
    #@users = User.active.all(:conditions => ["id NOT IN(:users)", {:users => [1, 2]}])
    @users = User.active.all
  end

  def save
    TimelogNormalizerUser.delete_all
    users = User.all(:conditions => ["id IN(:users)", {:users => params[:user]}])

    users.each do |user|
      user.timelog_normalizer_enable
    end    
    
    flash[:notice] = 'Ololo'
    redirect_to :action => "index"
  end
  
end
