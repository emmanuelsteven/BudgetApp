require 'rails_helper'

RSpec.describe 'Category Model Testing', type: :model do
  before(:each) do
    @user = User.create!(
      name: 'steven emmanuel',
      email: 'steve@mymail.com',
      password: 'yesyes',
      password_confirmation: 'yesyes'
    )

    @category = Category.create!(
      name: 'groceries',
      user: @user
    )
  end

  after(:each) do
    Category.delete_all
    User.delete_all
  end

  it 'should be valid with valid attributes' do
    expect(@category).to be_valid
  end

  it 'Should not be valid with invalid data' do
    @category.name = nil
    expect(@category).to_not be_valid
  end

  it 'should not be valid without a user' do
    @category.user = nil
    expect(@category).to_not be_valid
  end
end
