class Author < ApplicationRecord
  has_many :books, dependent: :nullify
  validates :name, presence: true, uniqueness: true
  validates :biography, presence: true

  scope :by_name, ->(by_name) {where(arel_table[:by_name].matches("%#{by_name}%"))}
end