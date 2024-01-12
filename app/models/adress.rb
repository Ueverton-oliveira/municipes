class Adress < ApplicationRecord
  # association
  belongs_to :citizen

  # validations
  validates :cep, :city, :neighborhood, :street, :state, presence: true
end
