# Class Name: Country
# Description: Country model class
# Version: 1.0
# Copyright: Telsoft
# Author: CuongCT
# Create Date: 06/03/2015
# Modify Date: 06/03/2015

class Country
  include Mongoid::Document

  #fields
  field :id, type: String
  field :name, type: String
  #indexes
  index({ id: 1 }, { unique: true })

end
