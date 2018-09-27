class Language < ApplicationRecord
  has_many :books, dependent: :nullify
  validates :language, presence: true
end