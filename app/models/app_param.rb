class AppParam
  include Mongoid::Document
  field :code, type: Integer
  field :name, type: String
  field :value, type: String
end
