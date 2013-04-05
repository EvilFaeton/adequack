require 'pry'

module Adequack
  InterfaceImplementationError = Class.new(::StandardError)

  class Core

    def self.implements(object, interface)
      new(object, interface).send(:validate_ducktype)
    end

    private

    def initialize(duck, interface)
      self.duck = duck
      self.interface = interface
    end

    def validate_ducktype
      check_method_implementation(get_methods interface.methods )
      check_method_implementation(get_methods(interface.instance_methods), true)
    end

    def check_method_implementation(methods, instance = false)
      #binding.pry
      methods.each do |method|
        if instance
          name = method
          defined = duck.method_defined?(method)
        else
          name = "self.#{method}"
          defined = duck.respond_to?(method)
        end

        raise InterfaceImplementationError, "object does not respond to #{name} method" unless defined
      end
    end

    attr_accessor :duck, :interface

    def get_methods(methods)
      methods - Object.methods
    end
  end
end