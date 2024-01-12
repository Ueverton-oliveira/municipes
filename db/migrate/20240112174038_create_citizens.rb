class CreateCitizens < ActiveRecord::Migration[7.1]
  def change
    create_table :citizens do |t|
      t.string :name
      t.string :cpf
      t.string :cns
      t.string :email
      t.date :birthday
      t.string :phone
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
