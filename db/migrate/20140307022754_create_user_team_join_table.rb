class CreateUserTeamJoinTable < ActiveRecord::Migration
  def change
    create_join_table :users, :matches do |t|
      # t.index [:user_id, :match_id]
      # t.index [:match_id, :user_id]
    end
  end
end
