module PunditNamespaces
  class PolicyFinder
    attr_reader :matcher

    def initialize(matcher)
      @matcher = matcher
    end

    def all_policies_for(obj)
      PunditNamespaces.namespaces.matches(matcher).map do |namespace|
        policy = policy_finder(namespace, obj).policy! if namespace.map(&:presence?).all?
        next policy_obj(policy, namespace) if policy
        policy = policy_finder(namespace, obj).policy
        policy_obj(policy, namespace)
      end.compact
    end

    private

    def policy_obj(policy, namespace)
      return unless policy
      { policy: policy,
        error: find_error(namespace).error }
    end

    def find_error(namespace)
      namespace
        .reverse
        .find { |ns| ns != Pundit::NotAuthorizedError } || Pundit::NotAuthorizedError
    end

    def policy_finder(namespace, obj)
      ns = namespace.map(&:name).delete_if { |n| n == :_root_namespace }
      Pundit::PolicyFinder.new([*ns, *obj])
    end
  end
end
