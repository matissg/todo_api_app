class TaskSerializer < ActiveModel::Serializer
  attributes :id, :title
  has_many :task_tags, key: :tags
end
