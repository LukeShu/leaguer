class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.reference :tournament

      t.timestamps
    end
  end
end
