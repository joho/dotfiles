#libaries
require 'rubygems' rescue nil
require 'wirble'
require 'hirb'

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
end
