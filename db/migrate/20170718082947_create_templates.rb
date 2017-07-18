class CreateTemplates < ActiveRecord::Migration[5.1]
  def change
    create_table :templates do |t|

      t.timestamps
    end
  end
end
