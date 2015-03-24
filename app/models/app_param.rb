class AppParam
  include Mongoid::Document
  field :code, type: String
  field :name, type: String, localize: true
  field :value, type: String
  field :type, type: String
  field :order, type: String
end
