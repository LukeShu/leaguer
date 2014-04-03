class CreateRemoteUsernames < ActiveRecord::Migration
  def change
    create_table :remote_usernames do |t|
      t.references :game, index: true
      t.references :user, index: true
      t.string :user_name

      t.timestamps
    end
  end
end
