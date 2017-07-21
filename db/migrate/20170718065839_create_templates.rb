class CreateTemplates < ActiveRecord::Migration[5.0]
  def change
    create_table :templates do |t|
      t.string :category
      t.string :description
      t.timestamps
    end
  end
end
