require 'acts_as_external_archive'
ActiveRecord::Base.send(:include, Twerno::Acts::External_Archive)