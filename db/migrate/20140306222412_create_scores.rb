class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.references :user, index: true
      t.references :match, index: true
      t.integer :value

      t.timestamps
    end
  end
end
