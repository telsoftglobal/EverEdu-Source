require 'test_helper'

class MaterialTypeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  # create default material types
  test "create material types" do
    assert MaterialType.create(_id: 'book', material_type_name: '本', show_priority: 1)
    assert MaterialType.create(_id: 'video', material_type_name: 'ビデオ', show_priority: 2)
    assert MaterialType.create(_id: 'document', material_type_name: 'ドキュメント', show_priority: 3)
    assert MaterialType.create(_id: 'others', material_type_name: '余', show_priority: 4)
  end

  test "find all "

end
