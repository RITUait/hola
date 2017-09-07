class CreateTemplates < ActiveRecord::Migration[5.0]
  def change
    create_table :templates do |t|
      t.text :contact_ids,array: true, default: []
      t.string :category
      t.string :paragraph
      t.string :title
      t.string :description
      t.belongs_to :user, index: true
      t.timestamps
    end
  end
end
