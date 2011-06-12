class Lugar < ActiveRecord::Base
  has_and_belongs_to_many :tags
  
  cattr_reader :per_page 
  @@per_page = 5
end
