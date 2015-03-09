# Class Name: Role
# Description: Role model class
# Version: 1.0
# Copyright: Telsoft
# Author: HuyenDT
# Create Date: 14/10/2014
# Modify Date: 28/10/2014
class Role
  include Mongoid::Document

  #Const
  ROLE_DEFAULT = 'Student'
  ROLE_STUDENT = 'Student'
  ROLE_MENTOR = 'Mentor'
  ROLE_ADMIN = 'Admin'

  #fields
  field :name, type: String
  field :priority, type: Integer, default: 0

  #indexes
  index({ name: 1 }, { unique: true, name: 'name_index' })

  class << self
    # this method return role default of system
    def get_role_default
      Role.where(name: ROLE_DEFAULT).first
    end

    # this method return mentor role
    def get_role_mentor
      Role.find_by(name: ROLE_MENTOR)
    end
  end

end
