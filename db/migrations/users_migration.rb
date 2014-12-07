Caminio::Sky::Migration.up :users do
  primary_key :id
  String :username
  String :password_digest
  DateTime :created_at
  DateTime :updated_at
end

