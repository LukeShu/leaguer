class CreateApiRequests < ActiveRecord::Migration
  def change
    create_table :api_requests do |t|
      t.string :api_name

      t.timestamps
    end
  end
end
