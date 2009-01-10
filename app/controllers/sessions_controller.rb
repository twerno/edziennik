class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :create  
  skip_before_filter :intro
  
  def intro
  end
  
  def index
    render :layout => "application"
  end
  
  def new
    redirect_to_user_page
  end

  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    if (params[:password_confirmation] == params[:password]) != nil
      @user.password = params[:password]
    end
    
    if !params[:email].nil?
      @user.email = params[:email]
    end
    
    @user.save(false)
    redirect_to '/'
  end

  def create
    logout_keeping_session!
    if using_open_id?
      open_id_authentication
    else
      password_authentication
    end
  end

  def destroy
    logout_killing_session!
    flash[:notice] = "You have been logged out."
    redirect_to root_path
  end
  
  def open_id_authentication
    authenticate_with_open_id do |result, identity_url|
      if result.successful? && self.current_user = User.find_by_identity_url(identity_url)
        successful_login
      else
        flash[:error] = result.message || "Sorry no user with that identity URL exists"
        @remember_me = params[:remember_me]
        render :action => :new
      end
    end
  end

  protected
  
  def redirect_to_user_page
    if rodzic?
      redirect_to :controller => :rodzic  , :action => :plan, :layout => :true
    elsif uczen?
      redirect_to uczen_plan_path, :layout => :true
    elsif admin?
      redirect_to :controller => :admin, :action => :index#, :layout => "application"
    elsif nauczyciel?
      redirect_to nauczyciel_plan_path (:layout => :true)
    end
  end
  
  def password_authentication
    user = User.authenticate(params[:login], params[:password])
    if user
      self.current_user = user
      successful_login
    else
      note_failed_signin
      @login = params[:login]
      @remember_me = params[:remember_me]
      render :action => :new
    end
  end
  
  
  def successful_login
    new_cookie_flag = (params[:remember_me] == "1")
    handle_remember_cookie! new_cookie_flag
    #redirect_back_or_default(root_path)
    
    redirect_to_user_page
    flash[:notice] = "Logged in successfully"
  end


  def note_failed_signin
    flash[:error] = "Couldn't log you in as '#{params[:login]}'"
    logger.warn "Failed login for '#{params[:login]}' from #{request.remote_ip} at #{Time.now.utc}"
  end
  
end
