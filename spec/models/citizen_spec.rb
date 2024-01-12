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
end
