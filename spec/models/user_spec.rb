require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validation" do
    it 'Saves a user with the correct name and password' do
      @user = User.new(first_name:"Nom", last_name: "guy", password: "pass", password_confirmation: "pass", email: "c@g")
      @user.save!
      expect(@user.first_name).to eql("Nom")
      end
    it 'Rejects a user with non-matching passwords' do
      @user = User.new(first_name:"Nom", last_name: "guy", password: "pass", password_confirmation: "notpass", email: "c@g")
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it 'Rejects users who do not confirm their password' do
      @user = User.new(first_name:"Nom", last_name: "guy", password: "pass", email: "c@g")
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password confirmation can't be blank")
    end
    it 'Rejects users without passwords' do
      @user = User.new(first_name:"Nom", last_name: "guy", email: "c@g")
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'Rejects email addresses already in the database' do
      @user = User.new(first_name:"Nom", last_name: "guy", password: "pass", password_confirmation: "pass", email: "c@g")
      @user.save!
      @invaliduser = User.new(first_name: "me", last_name: "guy", password: "notapassword", password_confirmation: "notapassword", email: "C@G")
      expect(@invaliduser).to_not be_valid
    end
    it 'Rejects users without a valid email address' do
      @user = User.new(first_name:"Nom", last_name: "guy", password: "pass", password_confirmation: "pass")
      expect(@user).to_not be_valid
    end
  end




  describe '.authenticate_with_credentials' do
    it 'returns nil if the user cannot be found' do
      @user = User.new(first_name:"Nom", last_name: "guy", password: "pass", password_confirmation: "pass", email: "c@g")
      valid = User.authenticate_with_credentials('c@g', 'pass')
      expect(valid).to be_nil
    end
    it 'should return the user data if the user exists' do
      @user = User.new(first_name:"Nom", last_name: "guy", password: "pass", password_confirmation: "pass", email: "c@g")
      @user.save!
      valid = User.authenticate_with_credentials('c@g', 'pass')
      expect(valid).to_not be_nil
    end
    it 'Should return valid data if the email contains trailing whitespace' do
      @user = User.new(first_name:"Nom", last_name: "guy", password: "pass", password_confirmation: "pass", email: " c@g ")
      @user.save!
      valid = User.authenticate_with_credentials('c@g', 'pass')
      expect(valid).to_not be_nil
    end
    it 'Should authenticate users with incorrectly cased email addresses' do 
      @user = User.new(first_name:"Nom", last_name: "guy", password: "pass", password_confirmation: "pass", email: " c@G ")
      @user.save!
      valid = User.authenticate_with_credentials('c@g', 'pass')
      expect(valid).to_not be_nil
    end
  end
end

