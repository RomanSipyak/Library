class Estimate < ApplicationRecord
  belongs_to :book
  belongs_to :user

  scope :by_user_id, ->(id) {where(arel_table[:user_id].eq(id))}

  def self.average_rating
    average(:rating)
  end
end