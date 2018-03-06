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
      each_leaf.inject([]) do |acc, node|
        acc += path_and_subpathes_to_root(node)
        acc
      end
    end

    def <<(node)
      tree << node
      new_tree(tree)
    end

    def path_to_root(node)
      path = collect_ancestors(node, [node.content]) { |nd| nd.parent.content }
      path[1..-1]
    end

    def path_and_subpathes_to_root(node)
      collect_ancestors(node, []) { |nd| path_to_root(nd) }
    end

    def collect_ancestors(node, accumulator = [])
      loop do
        break if node.is_root?
        accumulator << yield(node)
        node = node.parent
      end
      accumulator.reverse
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
