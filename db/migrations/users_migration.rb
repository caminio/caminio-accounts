Caminio::Sky::Migration.up :users do
  primary_key :id

  String :username
  String :firstname
  String :lastname

  String :password_digest
  String :email

  DateTime :created_at
  DateTime :updated_at
end

