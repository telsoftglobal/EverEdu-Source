require 'test_helper'

class CountryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test 'init Country' do
    File.open("/home/cuongct/StarTeam/EverEdu/SOURCE/JP-AES_v0.2/test/models/countries_test_data.yml", "r") do |f|
      f.each_line do |line|
        puts line
        id = line.split(',')[0].strip.gsub(/\n/, '')
        name = line.split(',')[1].strip.gsub(/\n/, '')
        country = Country.new(id: id, name: name)
        country.save



      end
    end
  end

  test 'remove country' do
    # Country.delete_all
    # country = Country.all
    # puts ''
  end
end
