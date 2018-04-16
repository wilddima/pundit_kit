class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record, options = {})
    @user = user
    @record = record
  end
end
