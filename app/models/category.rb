class Category < ApplicationRecord
  has_many :books, dependent: :nullify
  validates :title, presence: true, uniqueness: true
end