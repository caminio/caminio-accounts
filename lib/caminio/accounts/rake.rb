load "active_record/railties/databases.rake"
load File::expand_path("../tasks.rake",__FILE__)
ActiveRecord::Base.logger = nil