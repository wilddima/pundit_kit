module PunditKit
  module Helpers
    class UndefinedMatcherError < StandardError; end

    def authorize_all(record, *args)
      query, options = args

      if query.is_a?(Hash)
        options = query.dup
        query = nil
      end

      query ||= params[:action].to_s + '?'

      policy_namespaces(pundit_user, record, options).each do |policy|
        unless policy[:policy_obj].public_send(query)
          raise policy[:error], query: query, record: record, policy: policy
        end
      end

      record
    end

    def all_policies(record, options = {})
      policy_namespaces(pundit_user, record, options)
        .map { |policy| policy[:policy_obj] }
    end

    def pundit_namespace_matcher
      raise UndefinedMatcherError, 'undefined pundit_namespace_matcher'
    end

    def pundit_context; end

    def policy_finder
      PunditKit::PolicyFinder.new(pundit_namespace_matcher)
    end

    def policy_namespaces(user, record, options = {})
      current_context = pundit_context
      policies = policy_finder.all_policies_for(record)
      policies.map do |policy|
        policy_obj = policy[:policy].new(user, record, options)
        policy_obj.define_singleton_method(:context) { current_context }
        policy.merge(policy_obj: policy_obj)
      end
    end
  end
end
