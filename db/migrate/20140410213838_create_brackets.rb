class CreateBrackets < ActiveRecord::Migration
  def change
    create_table :brackets do |t|
      t.references :user, index: true
      t.references :tournament, index: true
      t.string :name

      t.timestamps
    end
  end
end
