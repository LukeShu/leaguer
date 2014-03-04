class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.references :tournament, index: true
      t.string :name

      t.timestamps
    end
  end
end
