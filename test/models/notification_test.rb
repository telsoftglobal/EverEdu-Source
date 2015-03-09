require 'test_helper'

class NotificationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "group by a field" do
    activity_type = Notification::COMMENT_TYPE
    object_id = '547c191e4875793695010000'
    object_type = 'Curriculum'

    # group by
    result = Notification.all.group_by {|n| [n.object_id] }

    keys = result.keys

    keys.each do |key|
      puts key
      puts key[0].to_s
      puts result[key].size
    end

  end

  test "group by multi fields" do
    activity_type = Notification::COMMENT_TYPE
    object_id = '547c191e4875793695010000'
    object_type = 'Curriculum'

    # group by
    result = Notification.all.group_by {|n| [n.object_type, n.object_id] }

    puts result.map

    map_result = result.map

    #print result
    result.map(&:first).each do |k|
      puts k
    end

    puts result.keys

    keys = result.keys

    keys.each do |key|
      puts key
      puts result[key].size
    end

  end

  test "map redure notification" do
      map = %Q{
        function() {
          emit(this.object_id, this.object_type, {count: 1})
        }
      }

      reduce = %Q{
        function(key, values) {
          var result = {count: 0};
          values.forEach(function(value) {
            result.count += value.count;
          });
          return result;
        }
      }

      results = Notification.where(activity_type: Notification::COMMENT_TYPE).
          map_reduce(map, reduce).out(inline: true)

      puts results.to_a
  end
end
