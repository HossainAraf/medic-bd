class Doctor < ApplicationRecord
  validates :order, presence: true,
                    numericality: { only_integer: true,
                                    greater_than_or_equal_to: 100_000,
                                    less_than_or_equal_to: 9_999_999 }
end
