module PunditNamespaces
  class PolicyFinder

    attr_reader :matcher

    def initialize(matcher)
      @matcher = matcher
    end

    def all_policies_for(obj)
      PunditNamespaces.namespaces.matches(matcher).map do |namespace|
        next policy_finder(namespace, obj).policy! if namespace.map(&:presence?).all?
        policy_finder(namespace, obj).policy
      end
    end

    private

    def policy_finder(namespace, obj)
      ns = namespace.map(&:name).delete_if { |n| n == :_root_namespace }
      Pundit::PolicyFinder.new([*ns, obj])
    end

  end
end
