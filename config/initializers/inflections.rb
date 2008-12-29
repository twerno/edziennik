# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format 
# (all these examples are active by default):
 ActiveSupport::Inflector.inflections do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
#   inflect.irregular 'person', 'people'
#   inflect.uncountable %w( fish sheep )
    inflect.irregular 'czlonek', 'czlonkowie'
    inflect.irregular 'dyrektor', 'dyrektorzy'
    inflect.irregular 'godzina', 'godziny'
    inflect.irregular 'grupa', 'grupy'
    inflect.irregular 'lekcja', 'lekcje'
    inflect.irregular 'lista', 'listy'
    inflect.irregular 'nauczyciel', 'nauczyciele'
    inflect.irregular 'obecnosc', 'obecnosci'
    inflect.irregular 'ocena', 'oceny'
    inflect.irregular 'plan', 'plany'
    inflect.irregular 'pracownik', 'pracownicy'    
    inflect.irregular 'przedmiot', 'przedmioty'
    inflect.irregular 'rodzic', 'rodzice'
    inflect.irregular 'semestr', 'semestry'
    inflect.irregular 'uczen', 'uczniowie'
 end
