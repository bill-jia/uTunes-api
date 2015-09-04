require 'rails_helper'

describe AlbumPolicy do
  subject { described_class }

  permissions :index? do
    it "allows access if there is no user" do
      expect(subject).to permit(nil, Album.new())
    end
    it "allows access if user is user" do
      expect(subject).to permit(User.new(role: "user"), Album.new())
    end
    it "allows access if user is producer" do
      expect(subject).to permit(User.new(role: "producer"), Album.new())
    end
    it "allows access if user is admin" do
      expect(subject).to permit(User.new(role: "admin"), Album.new())
    end              
  end

  permissions :show? do
    it "allows access if there is no user" do
      expect(subject).to permit(nil, Album.new())
    end
    it "allows access if user is user" do
      expect(subject).to permit(User.new(role: "user"), Album.new())
    end
    it "allows access if user is producer" do
      expect(subject).to permit(User.new(role: "producer"), Album.new())
    end
    it "allows access if user is admin" do
      expect(subject).to permit(User.new(role: "admin"), Album.new())
    end              
  end

  permissions :new? do
    it "denies access if there is no user" do
      expect(subject).not_to permit(nil, Album.new())
    end
    it "denies access if user is user" do
      expect(subject).not_to permit(User.new(role: "user"), Album.new())
    end
    it "allows access if user is producer" do
      expect(subject).to permit(User.new(role: "producer"), Album.new())
    end
    it "allows access if user is admin" do
      expect(subject).to permit(User.new(role: "admin"), Album.new())
    end              
  end

  permissions :create? do
    it "denies access if there is no user" do
      expect(subject).not_to permit(nil, Album.new())
    end
    it "denies access if user is user" do
      expect(subject).not_to permit(User.new(role: "user"), Album.new())
    end
    it "allows access if user is producer" do
      expect(subject).to permit(User.new(role: "producer"), Album.new())
    end
    it "allows access if user is admin" do
      expect(subject).to permit(User.new(role: "admin"), Album.new())
    end              
  end

  permissions :edit? do
    it "denies access if there is no user" do
      expect(subject).not_to permit(nil, Album.new())
    end
    it "denies access if user is user" do
      expect(subject).not_to permit(User.new(role: "user"), Album.new())
    end
    it "allows access if user is producer" do
      expect(subject).to permit(User.new(role: "producer"), Album.new())
    end
    it "allows access if user is admin" do
      expect(subject).to permit(User.new(role: "admin"), Album.new())
    end              
  end

  permissions :update? do
    it "denies access if there is no user" do
      expect(subject).not_to permit(nil, Album.new())
    end
    it "denies access if user is user" do
      expect(subject).not_to permit(User.new(role: "user"), Album.new())
    end
    it "allows access if user is producer" do
      expect(subject).to permit(User.new(role: "producer"), Album.new())
    end
    it "allows access if user is admin" do
      expect(subject).to permit(User.new(role: "admin"), Album.new())
    end              
  end    

  permissions :destroy? do
    it "denies access if there is no user" do
      expect(subject).not_to permit(nil, Album.new())
    end
    it "denies access if user is user" do
      expect(subject).not_to permit(User.new(role: "user"), Album.new())
    end
    it "allows access if user is producer" do
      expect(subject).to permit(User.new(role: "producer"), Album.new())
    end
    it "allows access if user is admin" do
      expect(subject).to permit(User.new(role: "admin"), Album.new())
    end              
  end
end
