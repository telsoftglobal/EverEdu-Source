require 'test_helper'

class WorkExperienceTest < ActiveSupport::TestCase
  test "to sentence" do
    sentences = Array.new
    sentences << 'sentence 1'
    sentences << 'sentence 2'
    sentences << 'sentence 3'
    sentences << 'sentence 4'

    puts sentences.to_sentence(:last_word_connector => ', ')
  end
end