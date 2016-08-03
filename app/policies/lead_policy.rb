class LeadPolicy < Struct.new(:user, :lead)
  
  def create?
    user.shares_any_group?(lead, as: :admin)
  end
  
  class Scope < Struct.new(:user, :scope)
    def resolve
      if user.admin?
        # An admin can see all the posts in the group(s) they are admin for
        scope.shares_any_group(user).as(:admin)
      else
        # Normal users can only see published posts in the same group(s).
        scope.shares_any_group(user).where(status: :repeated)
      end
    end
  end
  
end