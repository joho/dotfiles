#libaries
require 'rubygems' rescue nil
require 'wirble'

#load wirble
Wirble.init
Wirble.colorize

require 'utility_belt'

class Object
  def search_methods(regex)
    self.methods.select {|m| m =~ regex}
  end
  
  def my_methods
    (self.methods - Object.methods).sort
  end
end
