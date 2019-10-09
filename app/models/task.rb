class Task < ApplicationRecord

  attr_reader :tags
  #-- Associations -------------------------------------------------------------
  has_many :taggings, dependent: :destroy
  has_many :task_tags, class_name: "Tag", through: :taggings, source: :tag
  #-- Validations --------------------------------------------------------------
  validates :title, length: { in: 3..500, message: "3 to 500 characters allowed" },
                    presence: true


  def tags=(titles)
    validate_(titles)
    tags = titles.map{|title| title.tr('#', '').tr('@', '')}.uniq.reject(&:empty?)
    self.task_tags = tags.map do |tag|
      Tag.where(title: tag).first_or_create!
    end
  end

  private

  def validate_(titles)
    if titles.size > 30 || (!titles.is_a? Array)
      errors.add(:tags, "Up to 30 tags in array allowed")
      raise ActiveRecord::RecordInvalid, self
    end
  end

end
