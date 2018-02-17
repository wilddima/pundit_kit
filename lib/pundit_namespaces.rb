require 'tree'
require 'pry'
require 'pundit'
require 'pundit_namespaces/version'
require 'pundit_namespaces/namespace'
require 'pundit_namespaces/namespaces'
require 'pundit_namespaces/routes_tree'
require 'pundit_namespaces/policy_finder'

module PunditNamespaces
  def self.routes(&block)
    namespaces.instance_eval(&block)
    namespaces
  end

  def self.namespaces
    @namespaces ||= Namespaces.new
  end
end
