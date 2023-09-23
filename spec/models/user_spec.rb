require 'rails_helper'

RSpec.describe 'User Model Testing', type: :model do
  before(:each) do
    @user = User.create!(
      name: 'steven emmanuel',
      email: 'steve@mymail.com',
      password: 'yesyes',
      password_confirmation: 'yesyes'
    )
  end
  it 'should be valid with valid attributes' do
    expect(@user).to be_valid
  end

  it 'Should not be valid with invalid data' do
    @user.name = nil
    expect(@user).to_not be_valid
  end

  it 'should not be valid without a user' do
    @user.email = nil
    expect(@user).to_not be_valid
  end
end
