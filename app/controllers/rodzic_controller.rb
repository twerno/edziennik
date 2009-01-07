class RodzicController < ApplicationController
  
  
  def intro
    render :action => :plan, :parametrs =>  {:data => "2007-01-01"}
  end
  
  def plan
    render :layout => nil, :controller => :dzienniki, :action => :plan, :parametrs =>  {:data => "2007-01-01"}
  end

  def oceny
  end

  def obecnosci
  end

  def przedmioty
  end





end
