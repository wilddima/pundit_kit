module PunditNamespaces
  class Namespace
    attr_reader :name, :options, :match, :presence

    def initialize(name, options = {})
      @match = options.delete(:if) || ->(_) { true }
      @presence = options[:presence].nil? ? true : options.delete(:presence)
    end

    def match?(*args)
      match&.call(*args)
    end

    def presence?
      presence
    end
  end
end
