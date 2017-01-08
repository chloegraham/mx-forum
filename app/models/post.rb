class Post < ActiveRecord::Base
  enum location: {upper_north: "Upper North Island", lower_north: "Lower North Island", south: "South Island"}
  belongs_to :user
  default_scope -> { order(created_at: :desc) }

  validates :title, presence: true, length: { maximum: 40 }
  validates :content, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true
end
