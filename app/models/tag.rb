class Tag < ApplicationRecord

  #-- Associations -------------------------------------------------------------
  has_many :taggings
  has_many :tasks, through: :taggings
  #-- Validations --------------------------------------------------------------
  validates :title, length: { in: 3..100, message: "3 to 100 characters allowed" },
                    presence: true, uniqueness: true
  
end
