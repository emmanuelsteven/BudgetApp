require 'rails_helper'

RSpec.describe 'Purchase Show Page Testing', type: :feature do
  include Devise::Test::IntegrationHelpers

  before(:each) do
    @user = User.create!(
      name: 'steven emmanuel',
      email: 'steve@mymail.com',
      password: 'abcxyz123',
      password_confirmation: 'abcxyz123'
    )

    @category = Category.create!(
      name: 'groceries',
      user: @user
    )

    @icon_path = Rails.root.join('app', 'assets', 'images', 'bud1.jpg')

    @category.icon.attach(io: File.open(@icon_path), filename: 'bud1.jpg')

    @purchase = Purchase.create!(
      name: 'clothes',
      amount: 300,
      user: @user,
      created_at: '23 Sep 2023',
      category: @category
    )
  end

  describe 'page components' do
    before(:each) do
      sign_in @user
      visit category_purchases_path(@category)
    end

    it 'should see the purchase name' do
      expect(page).to have_content(@purchase.name)
    end

    it 'should see the purchase amount' do
      expect(page).to have_content(@purchase.amount)
    end

    it 'should see the purchase creation time' do
      expect(page).to have_content(@purchase.created_at.strftime('%e %b %Y'))
    end

    it 'should see the category it belongs to' do
      expect(page).to have_content(@category.name)
    end
  end

  describe 'page Interactions' do
    before(:each) do
      sign_in @user
      visit category_purchases_path(@category)
    end

    it 'should navigate to the add transaction page on click' do
      click_on('Add a transaction')

      expect(page).to have_current_path(new_category_purchase_path(@category))
    end
  end
end
