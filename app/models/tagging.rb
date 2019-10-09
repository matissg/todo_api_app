class Tagging < ApplicationRecord

  #-- Associations -------------------------------------------------------------
  belongs_to :tag
  belongs_to :task
  
end
