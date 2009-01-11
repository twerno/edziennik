class ArchivesController < ApplicationController
  before_filter :admin_rights  
  
  def show
    @archives = (Archive.rebuild_from_archive Archive.all).sort_by {|a| (a[:class]).updated_at}
  end
end
