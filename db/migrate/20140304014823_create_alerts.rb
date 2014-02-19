class CreateAlerts < ActiveRecord::Migration
  def change
    create_table :alerts do |t|
      t.reference :author
      t.text :message

      t.timestamps
    end
  end
end
