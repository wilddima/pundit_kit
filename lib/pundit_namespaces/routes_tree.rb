module PunditNamespaces
  class RoutesTree
    extend Forwardable
    attr_accessor :tree

    def_delegators :@tree, :each, :children, :each_leaf, :path_to_root, :[]

    def initialize(tree = Tree::TreeNode.new(:_root))
      @tree = tree
    end

    def find_node_by_stack(stack)
      stack.inject(tree) do |acc, val|
        acc = acc[val]
        acc
      end
    end

    def find_match(matcher)
      dup.tap do |dup_tree|
        dup_tree.each do |node|
          next unless node.content
          node.remove_from_parent! unless node.content.match?(matcher)
        end
      end
    end

    def all_pathes_to_root
      each_leaf.map { |node| path_to_root(node) }
    end

    def <<(node)
      tree << node
      new_tree(tree)
    end

    def path_to_root(node)
      path = [node.content]
      loop do
        break if node.is_root?
        path << node.parent.content
        node = node.parent
      end
      path.reverse[1..-1]
    end

    def dup
      copy = super
      copy.tree = tree.dup
      copy
    end

    def children
      new_tree(tree.children)
    end

    private

    def new_tree(tree)
      self.class.new(tree)
    end
  end
end
