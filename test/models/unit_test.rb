require 'test_helper'

class UnitTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  # create default units
  test "create units" do
    assert Unit.create(_id: 'second', unit_name: '秒', show_priority: 1)
    assert Unit.create(_id: 'minute', unit_name: '分', show_priority: 2)
    assert Unit.create(_id: 'hour', unit_name: '時', show_priority: 3)
    assert Unit.create(_id: 'day', unit_name: '日', show_priority: 4)
    assert Unit.create(_id: 'week', unit_name: '週', show_priority: 5)
    assert Unit.create(_id: 'month', unit_name: '月', show_priority: 6)
    assert Unit.create(_id: 'year', unit_name: '年', show_priority: 7)
  end

end
