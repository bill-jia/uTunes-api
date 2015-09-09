class PlaylistPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end
  def index?
  	true
  end
  def show?
  	record.public? || user == record.user || user.producer?
  end
  def update?
  	user && user == record.user
  end
  def create?
  	user && user == record.user
  end
  def destroy?
  	user && user == record.user
  end    
end
