class Caminio::Sky::User < Sequel::Model

  include Caminio::Sky::Model

  define_columns do
    String  :name
  end

end
