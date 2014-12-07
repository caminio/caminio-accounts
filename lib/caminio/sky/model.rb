module Caminio::Sky::Model

  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods

    def define_columns(&block)
      return if db.table_exists? table_name
      db.create_table table_name(), &block
    end

  end

end

module Caminio::Sky::Model

  def self.included(base)
    base.extend ClassMethods
    Caminio::Sky.register_model base
  end

  module ClassMethods

    def property(name, type, options={})
      @@properties ||= {}
      @@properties[name] = { type: type.to_s, options: options }
      # return if db.table_exists? table_name
      # db.create_table table_name() &block
    end

    def properties
      @@properties
    end

  end

end

