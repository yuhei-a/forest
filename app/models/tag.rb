class Tag < ApplicationRecord
  has_many :tag_tables, dependent: :destroy
  has_many :posts, through: :tag_tables
end
