module Caminio::Sky::API::Helper

  def logger
    Caminio::Sky::API::Root.logger
  end

  def users
    users = Arel::Table.new(:users)
  end

end
