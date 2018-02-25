module PunditNamespaces
  module Helpers
    class UndefinedMatcherError < StandardError; end

    def authorize(user, record, query)
      policy_namespaces(user, record).each do |policy|
        unless policy[:policy_obj].public_send(query)
          raise policy[:error], query: query, record: record, policy: policy
        end

        record
      end
    end

    def policy(user, record)
      policy_namespaces(user, record)
        .map{ |policy| policy[:policy_obj] }
    end

    def pundit_namespace_matcher
      raise UndefinedMatcherError, 'undefined pundit_namespace_matcher'
    end

    def policy_finder
      PunditNamespaces::PolicyFinder.new(pundit_namespace_matcher)
    end

    def policy_namespaces(user, record)
      policies = policy_finder.all_policies_for(record)
      policies.map do |policy|
        policy.merge(policy_obj: policy[:policy].new(user, record))
      end
    end
  end
end
