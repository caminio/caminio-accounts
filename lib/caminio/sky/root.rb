module Caminio::Sky::Root

  def self.join( *opts )
    File::join( Dir.pwd, opts )
  end

end
