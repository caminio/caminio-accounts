class CreateUsers < ActiveRecord::Migration

  def up
    create_table :users do |t|
      t.string    :username
      t.string    :firstname
      t.string    :lastname
      t.string    :email
      t.string    :password_digest
      t.datetime  :valid_until
      t.timestamps
    end
  end 

  def down
    drop_table :users
  end

end
