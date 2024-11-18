class District < ApplicationRecord
  has_many :chembers
  has_many :doctors, through: :chembers
end
