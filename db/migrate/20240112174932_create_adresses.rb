class CreateAdresses < ActiveRecord::Migration[7.1]
  def change
    create_table :adresses do |t|
      t.string :street
      t.string :complement
      t.string :neighborhood
      t.string :city
      t.string :state
      t.string :cep
      t.string :ibge_code
      t.references :citizen, null: false, foreign_key: true

      t.timestamps
    end
  end
end
