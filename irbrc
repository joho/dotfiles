#libaries
require 'rubygems' rescue nil
require 'wirble'
require 'hirb'
require 'pp'

#load wirble
Wirble.init
Wirble.colorize

# set up hirb
extend Hirb::Console

require 'utility_belt'
UtilityBelt.equip

class Object
  def search_methods(regex)
    self.methods.select {|m| m =~ regex}
  end
  
  def my_methods
    (self.methods - Object.methods).sort
  end

  def tap
    yield self
    self
  end

  def tapp
    pp self
    self
  end
end

def debug_active_record(to_stdio = true) 
  ActiveRecord::Base.logger = Logger.new(STDOUT)
  ActiveRecord::Base.logger.level = to_stdio ? Logger::DEBUG : Logger::WARN
  
  reload!
end
