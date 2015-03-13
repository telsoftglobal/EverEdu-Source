require 'test_helper'

class CountryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test 'init Country' do
    File.open("/home/cuongct/StarTeam/EverEdu/SOURCE/JP-AES_v0.2/test/models/countries_test_data.yml", "r") do |f|
      f.each_line do |line|
        puts line

        country = Country.new(name: line.strip)
        country.save



      end
    end
  end

end
