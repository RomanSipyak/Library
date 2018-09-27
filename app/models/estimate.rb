class Estimate < ApplicationRecord
  belongs_to :book
  belongs_to :user, inverse_of: :product_estimates

end