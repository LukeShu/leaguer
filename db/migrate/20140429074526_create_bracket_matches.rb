class CreateBracketMatches < ActiveRecord::Migration
  def change
    create_table :bracket_matches do |t|
      t.references :bracket, index: true
      t.references :match, index: true
      t.references :predicted_winner, index: true

      t.timestamps
    end
  end
end
