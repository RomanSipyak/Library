class Category < ApplicationRecord
  has_many :books, dependent: :nullify
  validates :title, :login, :email, presence: true
end