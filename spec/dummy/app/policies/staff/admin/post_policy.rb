module Staff
  module Admin
    class PostPolicy < ApplicationPolicy
      def index?
        return true if context == :admin
        false
      end

      def show?
        index?
      end

      def create?
        index?
      end

      def update?
        index?
      end

      def destroy?
        index?
      end
    end
  end
end
