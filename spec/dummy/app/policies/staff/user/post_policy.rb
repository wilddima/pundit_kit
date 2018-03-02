module Staff
  module User
    class PostPolicy < ApplicationPolicy
      def index?
        true
      end

      def show?
        true
      end

      def create?
        true
      end

      def update?
        true
      end

      def destroy?
        false
      end
    end
  end
end
