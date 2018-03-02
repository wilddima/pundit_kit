require 'tree'
require 'pry'
require 'pundit'
require 'pundit_namespaces/version'
require 'pundit_namespaces/namespace'
require 'pundit_namespaces/namespaces'
require 'pundit_namespaces/routes_tree'
require 'pundit_namespaces/routes_builder'
require 'pundit_namespaces/policy_finder'
require 'pundit_namespaces/helpers'

module PunditNamespaces
  class NoRoutesError < StandardError; end

  def self.routes(&block)
    routes_builder.build_by(block)
  end

  def self.routes_builder
    RoutesBuilder.new(namespaces)
  end

  def self.namespaces
    @namespaces ||= Namespaces.new
  end

  def self.find_namespaces_by(matcher)
    raise NoRoutesError, 'No routes defined' unless namespaces.filled?
    namespaces.matches(matcher)
  end

  def self.drop_namespaces!
    @namespaces = nil
  end

  def self.included(base)
    base.include(PunditNamespaces::Helpers)
    base.class_eval do
      helper PunditNamespaces::Helpers if respond_to?(:helper)
      if respond_to?(:helper_method)
        helper_method :authorize_all
        helper_method :policies
      end
    end
  end
end
