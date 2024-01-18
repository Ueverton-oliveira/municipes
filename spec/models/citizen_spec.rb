require 'rails_helper'

RSpec.describe Citizen, type: :model do
  describe 'associations' do
    it { should have_one(:address) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:cns) }
    it { should validate_presence_of(:cpf) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:birthday) }
    it { should validate_presence_of(:phone) }
  end

  context 'uniqueness validations' do
    it { should validate_uniqueness_of(:cpf) }
    it { should validate_uniqueness_of(:cns) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_uniqueness_of(:phone) }
  end

  context 'wrong value to validations' do
    it { should_not allow_value('test.com').for(:email) }
    it { should_not allow_value(12_345111_00).for(:phone) }
    it { should_not allow_value(123456).for(:cpf) }
    it { should_not allow_value(191.years.ago).for(:birthdate) }
  end

  context 'numericality validations' do
    it { should validate_numericality_of(:cpf) }
    it { should validate_numericality_of(:cns) }
  end
end
