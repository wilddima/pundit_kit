module PunditNamespaces
  class Namespaces
    def namespace(name, options = {}, &block)
      name = name.to_sym
      @parent ||= []

      ns = Namespace.new(name, options)
      last_node = @parent.inject(tree) do |acc, val|
        acc = acc[val]
        acc
      end
      last_node << Tree::TreeNode.new(name, ns)

      return unless block_given?

      @parent << name
      instance_eval(&block)
      @parent.pop
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
        res = [node.name]
        loop do
          break if node.is_root?
          res << node.parent.name
          node = node.parent
        end
        res.reverse[1..-1]
      end
    end

    def tree
      @tree ||= Tree::TreeNode.new(:_root)
    end
  end
end
