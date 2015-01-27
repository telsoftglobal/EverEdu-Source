require 'test_helper'

class RoleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "create_roles" do
    role_student = Role.new(name: 'Student')
    role_student.save

    role_mentor = Role.new(name: 'Mentor')
    role_mentor.save

    role_admin = Role.new(name: 'Admin')
    role_admin.save
  end

  test "get_role_default" do
    role = Role.get_role_default
    assert role.name = Role::ROLE_DEFAULT
  end


end
