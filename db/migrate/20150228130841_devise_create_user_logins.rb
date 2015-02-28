class DeviseCreateUserLogins < ActiveRecord::Migration

  def up
    create_table :user_logins do |t|
      t.integer  :user_id
      t.string :ip_address
      t.string :user_agent
      t.datetime :signed_in_at
      t.datetime :last_seen_at
      t.datetime :signed_out_at
    end

    add_index :user_logins, :user_id
  end

  def down
    drop_table :user_logins
  end

end
