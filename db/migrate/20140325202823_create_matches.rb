class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.references :tournament, index: true
      t.string :name
      t.references :winner, index: true

      t.timestamps
    end
  end
end
