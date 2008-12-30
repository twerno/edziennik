class CreateGrupy < ActiveRecord::Migration
  def self.up
    create_table :grupy do |t|
      t.string  :nazwa
      t.boolean :klasa            ## jesli grupa jest klasa to TRUE
      t.integer :grupa_id         ## jesli jest to grupa dzielaca klase
                                  ## to mamy tu id klasy, ktora dzieli
                                  ## jesli jest to grupa miedzyklasowa
                                  ## pole to przyjmuje wartosc nil
      t.integer :nauczyciel_id    ## id wychowawcy jesli jest klasa
      t.integer :aktualny_semestr ## numer aktualnego semestru (rok i polrocze)
      t.integer :pierwszy_semestr ## semestr od, ktorego internetowy dziennik zaczyna sledzic wyniki uczniow (moze byc taki sam jak aktualny semestr )
      t.integer :ostatni_semestr  ## przewidziana ilosc semestrow nauki
      
      
      
      t.boolean  :destroyed, :default => false
      #t.integer  :edited_by
      #t.text     :editors_stamp
      
      t.timestamps
    end
  end

  def self.down
    drop_table :grupy
  end
end
