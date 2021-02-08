require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validation" do
    it 'Saves a user with the correct name and password' do
      @user = User.new(name:"Nom", password: "pass", password_confirmation: "pass", email: "c@g")
      @user.save!
      expect(@user.name).to eql("Nom")
      end
    it 'Rejects a user with non-matching passwords' do
      @user = User.new(name:"Nom", password: "pass", password_confirmation: "notpass", email: "c@g")
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it 'Rejects users who do not confirm their password' do
      @user = User.new(name:"Nom", password: "pass", email: "c@g")
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password confirmation can't be blank")
    end
    it 'Rejects email addresses already in the database' do
      @user = User.new(name:"Nom", password: "pass", password_confirmation: "pass", email: "c@g")
      @user.save!
      @invaliduser = User.new(name: "me", password: "notapassword", password_confirmation: "notapassword", email: "c@g")
      expect(@invaliduser).to_not be_valid
    end
    it 'Rejects users without a valid email address' do
      @user = User.new(name:"Nom", password: "pass", password_confirmation: "pass")
      expect(@user).to_not be_valid
    end
  end
end

