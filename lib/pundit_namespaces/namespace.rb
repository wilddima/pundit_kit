module PunditNamespaces
  class Namespace
    attr_reader :name, :options, :match, :presence, :error

    def initialize(name, options = {})
      @name = name
      @match = options.delete(:if) || ->(_) { true }
      @presence = options[:presence].nil? ? true : options.delete(:presence)
      @error = options.delete(:error) || Pundit::NotAuthorizedError
    end

    def match?(*args)
      match&.call(*args)
    end

    def presence?
      presence
    end
  end
end
