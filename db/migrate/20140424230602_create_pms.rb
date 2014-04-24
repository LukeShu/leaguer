class CreatePms < ActiveRecord::Migration
  def change
    create_table :pms do |t|
      t.references :author, index: true
      t.references :recipient, index: true
      t.text :message
      t.text :subject
      t.references :conversation, index: true

      t.timestamps
    end
  end
end
