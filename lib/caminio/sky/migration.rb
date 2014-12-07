module Caminio::Sky::Migration

  def self.up(table_name, &block)
    return if Sequel::Model.db.table_exists? table_name
    Sequel::Model.db.create_table table_name, &block 
  end

end

# module Caminio::Sky::Model
#
#   def self.included(base)
#     base.extend ClassMethods
#     Caminio::Sky.register_model base
#   end
#
#   module ClassMethods
#
#     def property(name, type, options={})
#       @@properties ||= {}
#       @@properties[name] = { type: type.to_s, options: options }
#       # return if db.table_exists? table_name
#       # db.create_table table_name() &block
#     end
#
#     def properties
#       @@properties
#     end
#
#   end
#
# end
#
