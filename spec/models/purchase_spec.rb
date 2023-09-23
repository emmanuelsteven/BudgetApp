require 'rails_helper'

RSpec.describe 'Purchase Model Testing' do
  before(:each) do
    @user = User.create!(
      name: 'gisachris',
      email: 'gisa@mymail.com',
      password: 'abcxyz123',
      password_confirmation: 'abcxyz123'
    )

    @category = Category.create!(
      name: 'groceries',
      user: @user
    )

    @purchase = Purchase.create!(
      name: 'clothes',
      amount: 300,
      user: @user,
      category: @category
    )
  end

  after(:each) do
    Purchase.delete_all
    # User.delete_all
  end

  it 'should be valid with valid attributes' do
    expect(@purchase).to be_valid
  end

  it 'Should not be valid with invalid attributes' do
    @purchase.name = nil
    expect(@purchase).to_not be_valid
  end

  it 'should not be valid with wrong datatype' do
    @purchase.amount = 'text'
    expect(@purchase).to_not be_valid
  end

  it 'should have the user as the author' do
    expect(@purchase.user).to eq(@user)
  end
end
