class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end
  def index?
  	user && user.admin?
  end
  def show?
  	user && (user == record || user.admin?)
  end
  def update?
  	user && (user == record || user.admin?)
  end
  def create?
  	user == nil || user.admin?
  end
  def destroy?
  	user && (user == record || user.admin?)
  end  
end
