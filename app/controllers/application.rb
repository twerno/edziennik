class ApplicationController < ActionController::Base
  include ExceptionNotifiable
  include AuthenticatedSystem
  include RoleRequirementSystem

  helper :all # include all helpers, all the time
  helper_method :create_queries, :zalogowany, :admin?, :rodzic?, :uczen?, :nauczyciel?, :Create_Array
  protect_from_forgery :secret => 'b0a876313f3f9195e9bd01473bc5cd06'
  filter_parameter_logging :password, :password_confirmation
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
  
  protected
  
  # Automatically respond with 404 for ActiveRecord::RecordNotFound
  def record_not_found
    render :file => File.join(RAILS_ROOT, 'public', '404.html'), :status => 404
  end
  
  def get_editors_stamp
    "ip|!|" << request.env["REMOTE_ADDR"].to_s << "|!|req|!|" << request.env["HTTP_USER_AGENT"].to_s << "|!|"
  end
  
  ## arg postaci
  ## nazwa1=wartosc1&nazwa2=wartosc2&...&nazwan=wartoscn
  ## return:
  ## {:nazwa1=>wartosc1, ... }
  def queries_parameters arg
    a = {}
    arg.split('&').each do |key|
      a.merge!({key.split('=')[0] => key.split('=')[1]})
    end
    a
  end
  
  ## dziala dokladnie odwrotnie niz powyzsza metoda
  def create_queries arg
    a = ""
    arg.each_key do |key|
      a << ((a.empty?) ? "" : "&") 
      a << key.to_s << "=" << arg[key].to_s
    end
    a
  end
  
  def zalogowany
    return current_user.uczen      unless current_user.uczen.nil?
    return current_user.nauczyciel unless current_user.nauczyciel.nil?
    return current_user.rodzic     unless current_user.rodzic.nil?   
  end
  
  
  def admin?
    if !current_user.nil?
      if current_user.id == 1
        return true
      end
    end
    
    false
  end
  
  def uczen?
    if !current_user.nil?
      return (zalogowany.class.to_s == "Uczen") ? true : false
    end
    
    false
  end
  
  def rodzic?
    if !current_user.nil?
      return (zalogowany.class.to_s == "Rodzic") ? true : false
    end
  end
  
  def nauczyciel?
    #(zalogowany.class.to_s == "Nauczyciel") ? true : false
    false
  end
  
  def Create_Array arg
    a = []
    for i in 0..arg[0]-1
      a += [[nil]]
      for j in 0..arg[1]-2
        a[i] += [nil]
      end
    end
    a
  end
  
  
  def scope_or model, args
    s= "("
    args.each {|c|
      s << model << " = " << c.to_s << " OR " 
    }
    s = s[0..s.length-5]
    (s.length >= 2) ? s << ")" : ''
  end
  
  
end

