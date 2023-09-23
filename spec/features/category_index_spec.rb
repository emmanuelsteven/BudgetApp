require 'rails_helper'

RSpec.describe 'Category Index Page Testing', type: :feature do
  include Devise::Test::IntegrationHelpers

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

    @icon_path = Rails.root.join('app', 'assets', 'images', 'bud1.jpg')

    @category.icon.attach(io: File.open(@icon_path), filename: 'bud1.jpg')
  end

  describe 'page components' do
    before(:each) do
      sign_in @user
      visit categories_path(@user)
    end

    it 'should show category name on page' do
      expect(page).to have_content(@category.name)
    end

    it 'should show category icon on page' do
      expect(page).to have_css('.category_icon')
    end

    it 'Should have a total of zero with no transactions made' do
      expect(page).to have_content(0.0)
    end

    describe 'page interactions' do
      before(:each) do
        sign_in @user
        visit categories_path(@user)
      end

      it 'should navigate to the categories showpage when a category is clicked' do
        click_link(@category.name)
        expect(page).to have_current_path(category_purchases_path(@category))
      end

      it 'should navigate to the new category page when the add category button is clicked' do
        click_on('Add a category')
        expect(page).to have_current_path(new_category_path)
      end
    end
  end
end
