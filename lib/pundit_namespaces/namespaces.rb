module PunditNamespaces
  class Namespaces
    def namespace(name, options = {}, &block)
      name = name.to_sym
      node = new_node(name, new_namespace(name, options))

      tree.find_node_by_stack(parent) << node

      return unless block_given?

      parent << name
      instance_eval(&block)
      parent.pop
    end

    def root_namespace(options = {}, &block)
      namespace(:_root_namespace, options, &block)
    end

    def matches(matcher)
      match_tree = find_match(matcher)
      all_pathes(match_tree)
    end

    private

    def find_match(matcher)
      tree.dup.tap do |dup_tree|
        dup_tree.each do |node|
          next unless node.content
          node.remove_from_parent! unless node.content.match?(matcher)
        end
      end
    end

    def children_names(match_tree)
      match_tree.children.each_with_object([]) do |child, acc|
        acc << child.name
        acc << children_names(child) if child.has_children?
      end
    end

    def all_pathes(match_tree)
      match_tree.each_leaf.map do |node|
        match_tree.path_to_root(node)
      end
    end

    def tree
      @tree ||= RoutesTree.new
    end

    def parent
      @parent ||= []
    end

    def new_node(name, ns)
      Tree::TreeNode.new(name, ns)
    end

    def new_namespace(name, options)
      Namespace.new(name, options)
    end
  end
end
