class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :picture do |attachable|
    attachable.variant :thumb, resize_to_limit: [500, 500]
  end
end
