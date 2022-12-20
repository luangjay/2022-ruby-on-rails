class Item < ApplicationRecord
  has_one_attached :picture do |attachable|
    attachable.variant :thumb, resize_to_fill: [200, 200]
  end
end
