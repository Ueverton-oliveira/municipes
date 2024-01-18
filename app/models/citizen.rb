class Citizen < ApplicationRecord
  # associations
  has_one_attached :photo

  has_one :address, dependent: :destroy
  accepts_nested_attributes_for :address, allow_destroy: true

  # validations
  validates :name, :cns, :cpf, :email, :birthday, :phone, :photo,
            presence: true

  validates :name, format: { with: /([\w\-']{2,})(\s+)([\w\-']{2,})/ }, if: :name
  validates :cpf, length: { is: 11 }
  validate :valid_cpf, if: :cpf
  validate :birthdate_data_range, if: :birthdate
  validates :cns, length: { is: 15 }
  validates :cpf, :cns, numericality: { only_integer: true }
  validates :phone, length: { is: 11 }
  validates :phone, phone: true, if: :phone
  # validates :email, email: true, if: :email


  validates :cpf, :email, :phone, :cns, uniqueness: true

  scope :search_by_name, ->(name) { where('lower(name) like ?', "%#{name.downcase}%") }

  def self.search_by_name(name)
    where("name LIKE ?", "%#{name}%")
  end

  private

  def valid_cpf
    errors.add(:cpf, I18n.t('errors.messages.invalid')) unless CPF.valid?(cpf)
  end

  def birthdate_data_range
    unless ((120.years.ago)..(1.day.ago)).cover?(birthdate)
      errors.add(:birthdate,
                 I18n.t('errors.messages.invalid'))
    end
  end
end
