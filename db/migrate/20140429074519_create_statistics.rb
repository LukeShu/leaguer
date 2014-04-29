class CreateStatistics < ActiveRecord::Migration
  def change
    create_table :statistics do |t|
      t.references :user, index: true
      t.references :match, index: true
      t.string :name
      t.text :json_value

      t.timestamps
    end
  end
end
