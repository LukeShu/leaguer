class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.references :tournament, index: true

      t.timestamps
    end
  end
end
