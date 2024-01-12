FactoryBot.define do
  factory :citizen do
    name { "MyString" }
    cpf { "MyString" }
    cns { "MyString" }
    email { "MyString" }
    birthday { "2024-01-12" }
    phone { "MyString" }
    active { false }

    address { build(:address, citizen: instance) }
  end
end
