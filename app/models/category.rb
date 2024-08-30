class Category < ApplicationRecord
  has_many :events, class_name: "Event", foreign_key: "category_id", dependent: :destroy
end
