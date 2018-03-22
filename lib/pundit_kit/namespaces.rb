module PunditKit
  class Namespaces
    def namespace(name, options = {}, &block)
      name = name.to_sym
      node = new_node(name, new_namespace(name, options))

      push_node_to_tree(stack, node)

      return unless block_given?

      stack << name
      instance_eval(&block)
      stack.pop
    end

    def root_namespace(options = {}, &block)
      namespace(:_root_namespace, options, &block)
    end

    def matches(matcher)
      tree.find_match(matcher)
          .all_pathes_to_root
    end

    def filled?
      @filled ||= false
    end

    private

    def tree
      @tree ||= RoutesTree.new
    end

    def stack
      @stack ||= []
    end

    def new_node(name, ns)
      Tree::TreeNode.new(name, ns)
    end

    def new_namespace(name, options)
      Namespace.new(name, options)
    end

    def push_node_to_tree(stack, node)
      @filled = true
      tree.find_node_by_stack(stack) << node
    end
  end
end
