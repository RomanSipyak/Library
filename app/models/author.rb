class Author < ApplicationRecord
  has_many :books, dependent: :nullify
  validates :name, presence: true, uniqueness: true
  validates :biography, presence: true
end