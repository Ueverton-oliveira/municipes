# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MunicipeDecorator do
  let(:citizen) { build(:citizen) }

  it { expect(citizen.decorate.birthdate).to eq I18n.l(citizen.birthdate) }
  it { expect(citizen.decorate.cpf).to eq CPF.new(citizen.cpf).formatted }
  it { expect(citizen.decorate.phone).to eq Phonelib.parse(citizen.phone).national }
  it { expect(citizen.decorate.status).to eq I18n.t('activerecord.attributes.citizen.status.active') }
end
