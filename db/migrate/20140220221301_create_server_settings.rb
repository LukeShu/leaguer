class CreateServerSettings < ActiveRecord::Migration
  def change
    create_table :server_settings do |t|

      t.timestamps
    end
  end
end
