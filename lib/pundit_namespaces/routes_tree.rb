module PunditNamespaces
  class RoutesTree
    extend Forwardable
    attr_accessor :tree

    def_delegators :tree, :<<, :each, :children

    def initialize
      @tree = Tree::TreeNode.new(:_root)
    end

    def find_node_by_stack(stack)
      stack.inject(tree) do |acc, val|
        acc = acc[val]
        acc
      end
    end

    def path_to_root(node)
      path = [node.name]
      loop do
        break if node.is_root?
        path << node.parent.name
        node = node.parent
      end
      path.reverse[1..-1]
    end

    def dup
      copy = self.dup
      copy.tree = self.tree.dup
      copy
    end
  end
end
