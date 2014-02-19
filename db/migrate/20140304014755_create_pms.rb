class CreatePms < ActiveRecord::Migration
  def change
    create_table :pms do |t|
      t.reference :author
      t.reference :recipient
      t.text :message

      t.timestamps
    end
  end
end
