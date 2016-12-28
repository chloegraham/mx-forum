class Post < ActiveRecord::Base
	enum location: {upper_north: "Upper North Island", lower_north: "Lower North Island", south: "South Island"}
  belongs_to :user
  #validates :content, length: { maximum: 140 }, presence: true
  validates_presence_of :title
end
