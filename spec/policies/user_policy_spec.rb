require 'rails_helper'

describe UserPolicy do

  let(:user) { User.new }
  subject { described_class }

  permissions :index? do
    it "denies access if there is no user" do
      expect(subject).not_to permit(nil, User.new())
    end
    it "denies access if user is user" do
      expect(subject).not_to permit(User.new(role: "user"), User.new())
    end
    it "denies access if user is producer" do
      expect(subject).not_to permit(User.new(role: "producer"), User.new())
    end
    it "allows access if user is admin" do
      expect(subject).to permit(User.new(role: "admin"), User.new())
    end              
  end

  permissions :show? do
    it "denies access if there is no user" do
      expect(subject).not_to permit(nil, User.new())
    end
    it "allows access if user is user and self" do
      expect(subject).to permit(user=User.new(role: "user"), user)
    end
    it "denies access if user is user and not self" do
      expect(subject).not_to permit(User.new(role: "user"), User.new())
    end
    it "allows access if user is producer and self" do
      expect(subject).to permit(user=User.new(role: "producer"), user)
    end    
    it "denies access if user is producer and not self" do
      expect(subject).not_to permit(User.new(role: "producer"), User.new())
    end
    it "allows access if user is admin and self" do
      expect(subject).to permit(user=User.new(role: "admin"), user)
    end
    it "allows access if user is admin not self" do
      expect(subject).to permit(User.new(role: "admin"), User.new())
    end                           
  end

  permissions :new? do
    it "allows access if there is no user" do
      expect(subject).to permit(nil, User.new())
    end
    it "denies access if user is user" do
      expect(subject).not_to permit(User.new(role: "user"), User.new())
    end
    it "denies access if user is producer" do
      expect(subject).not_to permit(User.new(role: "producer"), User.new())
    end
    it "allows access if user is admin" do
      expect(subject).to permit(User.new(role: "admin"), User.new())
    end              
  end

  permissions :create? do
    it "denies access if there is no user" do
      expect(subject).to permit(nil, User.new())
    end
    it "denies access if user is user" do
      expect(subject).not_to permit(User.new(role: "user"), User.new())
    end
    it "denies access if user is producer" do
      expect(subject).not_to permit(User.new(role: "producer"), User.new())
    end
    it "allows access if user is admin" do
      expect(subject).to permit(User.new(role: "admin"), User.new())
    end              
  end

  permissions :edit? do
    it "denies access if there is no user" do
      expect(subject).not_to permit(nil, User.new())
    end
    it "allows access if user is user and self" do
      expect(subject).to permit(user=User.new(role: "user"), user)
    end
    it "denies access if user is user and not self" do
      expect(subject).not_to permit(User.new(role: "user"), User.new())
    end
    it "allows access if user is producer and self" do
      expect(subject).to permit(user=User.new(role: "producer"), user)
    end    
    it "denies access if user is producer and not self" do
      expect(subject).not_to permit(User.new(role: "producer"), User.new())
    end
    it "allows access if user is admin and self" do
      expect(subject).to permit(user=User.new(role: "admin"), user)
    end
    it "allows access if user is admin not self" do
      expect(subject).to permit(User.new(role: "admin"), User.new())
    end                           
  end

  permissions :update? do
    it "denies access if there is no user" do
      expect(subject).not_to permit(nil, User.new())
    end
    it "allows access if user is user and self" do
      expect(subject).to permit(user=User.new(role: "user"), user)
    end
    it "denies access if user is user and not self" do
      expect(subject).not_to permit(User.new(role: "user"), User.new())
    end
    it "allows access if user is producer and self" do
      expect(subject).to permit(user=User.new(role: "producer"), user)
    end    
    it "denies access if user is producer and not self" do
      expect(subject).not_to permit(User.new(role: "producer"), User.new())
    end
    it "allows access if user is admin and self" do
      expect(subject).to permit(user=User.new(role: "admin"), user)
    end
    it "allows access if user is admin not self" do
      expect(subject).to permit(User.new(role: "admin"), User.new())
    end                           
  end

  permissions :destroy? do
    it "denies access if there is no user" do
      expect(subject).not_to permit(nil, User.new())
    end
    it "allows access if user is user and self" do
      expect(subject).to permit(user=User.new(role: "user"), user)
    end
    it "denies access if user is user and not self" do
      expect(subject).not_to permit(User.new(role: "user"), User.new())
    end
    it "allows access if user is producer and self" do
      expect(subject).to permit(user=User.new(role: "producer"), user)
    end    
    it "denies access if user is producer and not self" do
      expect(subject).not_to permit(User.new(role: "producer"), User.new())
    end
    it "allows access if user is admin and self" do
      expect(subject).to permit(user=User.new(role: "admin"), user)
    end
    it "allows access if user is admin not self" do
      expect(subject).to permit(User.new(role: "admin"), User.new())
    end                           
  end
end
