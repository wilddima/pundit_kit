require 'tree'
require 'pundit'
require 'pundit_kit/version'
require 'pundit_kit/namespace'
require 'pundit_kit/namespaces'
require 'pundit_kit/routes_tree'
require 'pundit_kit/routes_builder'
require 'pundit_kit/policy_finder'
require 'pundit_kit/helpers'

module PunditKit
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
    base.include(PunditKit::Helpers)
    base.class_eval do
      helper PunditKit::Helpers if respond_to?(:helper)
      if respond_to?(:helper_method)
        helper_method :authorize_all
        helper_method :policies
      end
    end
  end
end
