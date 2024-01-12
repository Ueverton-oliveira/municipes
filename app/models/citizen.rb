class Citizen < ApplicationRecord
  # associations
  has_one_attached :photo

  has_one :address, dependent: :destroy
  accepts_nested_attributes_for :address

  # validations
  validates :name, :cns, :cpf, :email, :birthday, :phone, :photo,
            presence: true
end
