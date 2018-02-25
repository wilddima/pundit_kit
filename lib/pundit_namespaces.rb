require 'tree'
require 'pry'
require 'pundit'
require 'pundit_namespaces/version'
require 'pundit_namespaces/namespace'
require 'pundit_namespaces/namespaces'
require 'pundit_namespaces/routes_tree'
require 'pundit_namespaces/policy_finder'
require 'pundit_namespaces/helpers'

module PunditNamespaces
  def self.routes(&block)
    namespaces.instance_eval(&block)
    namespaces
  end

  def self.namespaces
    @namespaces ||= Namespaces.new
  end

  def self.included(base)
    base.include(PunditNamespaces::Helpers)
    base.class_eval do
      helper PunditNamespaces::Helpers if respond_to?(:helper)
      if respond_to?(:helper_method)
        helper_method :policy
        helper_method :pundit_namespace_matcher
        helper_method :pundit_user
      end
    end
  end
end
