class ArchivesController < ApplicationController
  before_filter :admin_rights  
  
  def index
    @archives = (Archive.rebuild_from_archive Archive.all).sort_by {|a| (a[:class]).updated_at}
    render :layout => "application" unless params[:layout].nil?
  end
  
  def show
    if params[:id].nil? && !params[:class_name].nil?
      @archives = (Archive.rebuild_from_archive Archive.find_all_by_class_name params[:class_name]).sort_by {|a| (a[:class]).updated_at}
      render :layout => "application"
    elsif !params[:id].nil? && !params[:class_name].nil?
      @archives = (Archive.rebuild_from_archive Archive.find_all_by_class_name_and_class_id params[:class_name], params[:id]).sort_by {|a| (a[:class]).updated_at}
      render :layout => "application"
    else
      redirect_to :action => :index, :layout => "application"
    end
  end
  
  def restore
    Archive.restore params[:id], get_editors_stamp, current_user
    
    redirect_to :action => :show, :id => params[:id], :class_name => params[:class_name]
  end
end
