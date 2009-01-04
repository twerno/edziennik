class DziennikiController < ApplicationController
  def plan
    @godziny = Godzina.existing.find(:all, :order => :begin)
    @user    = 1 
  end
end
