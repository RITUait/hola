class CreateContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :contacts do |t|
      t.string  :name
      t.string  :email
      t.boolean :sent_or_not
      t.timestamps
    end
  end
end
