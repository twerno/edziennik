class Nauczyciel < ActiveRecord::Base
  belongs_to :user
  has_one    :grupa  #wychowawca
  has_many   :pnjts  #PRZEDMIOT-NAUCZYCIEL JOIN MODEL
  has_many   :przedmioty, :through => :pnjts
  has_many   :oceny
  has_many   :listy

  
  acts_as_external_archive
  
  def utworz_konto
    if self.user.nil?
      user            = self.build_user
      user.login      = user.new_random_password self.imie
      user.password   = user.new_random_password self.nazwisko
      #user.class_name =  
      wrk1 = user.register!
      if wrk1
        @user.activate!
      end
      
    end
  end
end
