class CreateAccessTokens < ActiveRecord::Migration

  def up
    create_table :access_tokens do |t|
      t.string      :token
      t.datetime    :expires_at
      t.references  :user
      t.timestamps
    end
  end 

  def down
    drop_table :access_tokens
  end

end
