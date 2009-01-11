class ArchivesController < ApplicationController
  before_filter :admin_rights  
  
  def index
    #@archives = (Archive.rebuild_from_archive Archive.all).sort_by {|a| (a[:class]).updated_at}
    @a = Archive.search (nil, params[:page])
    @archives = (Archive.rebuild_from_archive @a)
    render :layout => "application" unless params[:layout].nil?
  end
  
  def show
    search = {:class_id   => params[:class_id], 
              :class_name => params[:class_name], 
              :edited_by  => params[:edited_by],
              :editors_ip => params[:editors_ip],
              :editors_browser => params[:editors_browser],
              :method          => params[:method]
              }

    @a = Archive.search (search, params[:page])
    @archives = (Archive.rebuild_from_archive @a)#.sort_by {|a| (a[:class]).updated_at}
    render :layout => "application"
  end
  
  def restore
    Archive.restore params[:id], get_editors_stamp
    
    redirect_to :action => :show, :class_id => params[:class_id], :class_name => params[:class_name]
  end
end
