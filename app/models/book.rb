class Book < ApplicationRecord
  belongs_to :author, counter_cache: :books_count
  belongs_to :category, counter_cache: :books_count
  belongs_to :language, counter_cache: :books_count
  has_many :units, dependent: :destroy
  has_many :estimates, dependent: :destroy
  has_many :users, through: :estimates

  validates :title, presence: true
  validates :year, presence: true
  validates :description, presence: true
  validates :year, numericality: { only_integer: true,
                                   greater_than: 1000,
                                   less_than: Time.current.year }
end