class PostPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end
  def index?
  	true
  end
  def show?
  	true
  end
  def update?
  	user && user.producer?
  end
  def create?
  	user && user.producer?
  end
  def destroy?
  	user && user.producer?
  end  
end
