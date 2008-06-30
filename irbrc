#libaries
require 'rubygems' rescue nil
require 'wirble'

#load wirble
Wirble.init
Wirble.colorize

class Object
  def search_methods(regex)
    self.methods.select {|m| m =~ regex}
  end
end
