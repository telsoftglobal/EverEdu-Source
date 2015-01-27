require 'test_helper'

class UserCategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "insert a record" do
    # user_category = UserCategory.
    user = User.find_by(user_name: 'hapt')
    category = Category.find_by(category_name: 'Banking')
    level = Level.find_by(level_name: 'Manager')
    assert user_category = UserCategory.create(user_id: user.id, category_id: category.id, level_id: level.id)
  end

  test "get user category" do
    user = User.find_by(user_name: 'hapt')
    assert user_category = UserCategory.find_by(user_id: '5461f725486150473f000000')
    # puts user_category.user.user_name
    puts user_category.category.category_name
    levels = user_category.category.levels
    levels.each do |level|
      puts level.level_name
    end
    puts user_category.level.level_name
  end

  test "get all level of category" do
    category = Category.find_by(category_name: 'IT')
    levels = category.levels
    levels.each do |level|
      puts level.level_order
      puts level.level_name
    end
  end
end
