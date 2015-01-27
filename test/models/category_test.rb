require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

  #generate test data from categories_test_data.yml store category list
  test "generate_test_data" do
    show_priority = 1
    parent = nil

    File.open("/home/huyendt/Data/Telsoft/Global/Projects/JP-AES/SOURCE/JP-AES_v0.2/db/categories_test_data.yml", "r") do |f|
      f.each_line do |line|
        puts line
        if line =~ /^-/
          category = Category.new(category_name: line.strip.gsub!(/^-/, ''), show_priority: show_priority)
          if !parent.nil?
            category.parent = parent
          end
          show_priority += 1
          assert category.save

        else
          category = Category.new(category_name: line.strip, show_priority: show_priority)
          show_priority = show_priority + 1
          assert category.save
          parent = category
        end

        Level.create(level_name: 'New Grad/Entry Level/Internship', level_order: 1, category_id: category.id)
        Level.create(level_name: 'Experienced (Non-Manager)', level_order: 2, category_id: category.id)
        Level.create(level_name: 'Team Leader/Supervisor', level_order: 3, category_id: category.id)
        Level.create(level_name: 'Manager', level_order: 4, category_id: category.id)
        Level.create(level_name: 'Vice Director', level_order: 5, category_id: category.id)
        Level.create(level_name: 'CEO', level_order: 6, category_id: category.id)
        Level.create(level_name: 'Vice President', level_order: 7, category_id: category.id)
        Level.create(level_name: 'President', level_order: 8, category_id: category.id)
      end
      f.close
    end
  end

  test "generate_test_data2" do
    assert Level.delete_all({})

    File.open("/home/hapt/Documents/OUTSOURCE/JP-AES/SOURCE/JP-AES_v0.2/test/models/categories_test_data.yml", "r") do |f|
      i = 0
      f.each_line do |line|
        puts line
        if line =~ /^-/
          category = Category.find_by(category_name: line.strip.gsub!(/^-/, ''))
        else
          category = Category.find_by(category_name: line.strip)
        end
          # Level.create(level_name: 'New Grad/Entry Level/Internship', level_order: 1, category_id: category.id, xaxis: 0, yaxis: 0, description: 'After university, you are new graduate of internship.')
          # Level.create(level_name: 'Experienced (Non-Manager)', level_order: 2, category_id: category.id, xaxis: 1, yaxis: 7)
          # Level.create(level_name: 'Team Leader/Supervisor', level_order: 3, category_id: category.id, xaxis: 2, yaxis: 10)
          # Level.create(level_name: 'Manager', level_order: 4, category_id: category.id, xaxis: 3, yaxis: 15)
          # Level.create(level_name: 'Vice Director', level_order: 5, category_id: category.id, xaxis: 4, yaxis: 19)
          # Level.create(level_name: 'CEO', level_order: 6, category_id: category.id, xaxis: 5, yaxis: 22)
          # Level.create(level_name: 'Vice President', level_order: 7, category_id: category.id, xaxis: 6, yaxis: 26)
          # Level.create(level_name: 'President', level_order: 8, category_id: category.id, xaxis: 7, yaxis: 27)
        assert Level.create(level_name: 'New Grad/Entry Level/Internship', level_order: 1, category_id: category.id,yaxis: 0, description:'<p><b>Description:</b></p><p>You can work that is not related to the management to further hone my experience, work skills</p><p><b>Requirement:</b></p><p>- University graduate, majoring in '+category.category_name+'</p><p>- Good English skills</p><p>- Flexible, ability to work independently</p><p>- Good interpersonal skills and can work under pressure.<br></p>')
        assert Level.create(level_name: 'Experienced (Non-Manager)', level_order: 2, category_id: category.id,yaxis: 7,description:'<p><b>Description:</b></p><p>You can work that is not related to the management to further hone my experience, work skills</p><p><b>Requirement:</b></p><p>- University graduate, majoring in '+category.category_name+'</p><p>- Good English skills</p><p>- Flexible, ability to work independently</p><p>- Good interpersonal skills and can work under pressure</p><p>- You have at least experience 2 years and join at least 2 project.<br></p>')
        assert Level.create(level_name: 'Team Leader/Supervisor', level_order: 3, category_id: category.id,yaxis: 17,description:'<p><b>Description:</b></p><p>Team leader, guiding people to work, participate in the development, quality assurance project</p><p><b>Requirement:</b></p><p>- University graduate, majoring in '+category.category_name+'</p><p>- Good English skills</p><p>- Flexible, ability to work independently</p><p>- Good interpersonal skills and can work under pressure</p><p>- You have at least experience 3 years</p><p>- Have leadership skills.<br></p>')
        assert Level.create(level_name: 'Manager', level_order: 4, category_id: category.id,yaxis: 27,description:'<p><b>Description:</b></p><p>Project management, human resource management</p><p><b>Requirement:</b></p><p>- University graduate, majoring in '+category.category_name+'</p><p>- Good English skills</p><p>- Flexible, ability to work independently</p><p>- Good interpersonal skills and can work under pressure</p><p>- You have at least experience 3 years</p><p>- Have leadership skills.</p><p>Experience in project management with a team of 10 or more.<br></p>')
        assert Level.create(level_name: 'Vice Director', level_order: 5, category_id: category.id,yaxis: 35,description:'<p><b>Description:</b></p><p>Project management, human resource management</p><p><b>Requirement:</b></p><p>- University graduate, majoring in '+category.category_name+'</p><p>- Good English skills</p><p>- Flexible, ability to work independently</p><p>- Good interpersonal skills and can work under pressure</p><p>- Have leadership skills</p><p>Good organizational and planning skills.<br></p>')
        assert Level.create(level_name: 'CEO', level_order: 6, category_id: category.id,yaxis: 42,description:'<p><b>Description:</b></p><p>Project management, human resource management</p><p><b>Requirement:</b></p><p>- University graduate, majoring in '+category.category_name+'</p><p>- Good English skills</p><p>- Flexible, ability to work independently</p><p>- Good interpersonal skills and can work under pressure</p><p>- You have at least experience 3 years</p><p>- Have leadership skills.<br></p>')
        assert Level.create(level_name: 'Vice President', level_order: 7, category_id: category.id,yaxis: 50,description:'<p><b>Description:</b></p><p>Project management, human resource management</p><p><b>Requirement:</b></p><p>- University graduate, majoring in '+category.category_name+'</p><p>- Good English skills</p><p>- Flexible, ability to work independently</p><p>- Good interpersonal skills and can work under pressure</p><p>- You have at least experience 3 years</p><p>- Have leadership skills.<br></p>')
        assert Level.create(level_name: 'President', level_order: 8, category_id: category.id,yaxis: 55,description:'<p><b>Description:</b></p><p>Project management, human resource management</p><p><b>Requirement:</b></p><p>- University graduate, majoring in '+category.category_name+'</p><p>- Good English skills</p><p>- Flexible, ability to work independently</p><p>- Good interpersonal skills and can work under pressure</p><p>- You have at least experience 3 years</p><p>- Have leadership skills.<br></p>')

        # assert Level.create(level_name: 'Experienced (Non-Manager)', level_order: 2, category_id: category.id,yaxis: 7,description:'You have at least experience 2 years and experience about your job.')
        # assert Level.create(level_name: 'Team Leader/Supervisor', level_order: 3, category_id: category.id,yaxis: 17,description:'You have at least experience 3 years, experience about your job')
        # assert Level.create(level_name: 'Manager', level_order: 4, category_id: category.id,yaxis: 27,description:'You have at least experience 1 years about Team Leader/Supervisor')
        # assert Level.create(level_name: 'Vice Director', level_order: 5, category_id: category.id,yaxis: 35,description:'You have at least experience 2 years about Manager. You have to study about Business Administration')
        # assert Level.create(level_name: 'CEO', level_order: 6, category_id: category.id,yaxis: 42,description:'You have at least experience 2 years about Manager. You have to study about Business Administration, ')
        # assert Level.create(level_name: 'Vice President', level_order: 7, category_id: category.id,yaxis: 50,description:'You have at least experience 3 years about Manager, CEO')
        # assert Level.create(level_name: 'President', level_order: 8, category_id: category.id,yaxis: 55,description:'You have at least experience 3 years about Vice President')
        # end

      end
      f.close
    end
  end

  #test get all category
  test "get all categories" do
    categories = Category.where(status: 1).asc(:show_priority, :category_name)
    categories.each do |category|
      puts category.category_name
    end
  end

  #test get category by name like IT
  test "get category by name" do
    categories = Category.where(category_name: /IT/)
    categories.each do |category|
      puts category.category_name
    end
    assert_equal categories.size, 3
  end

  #test get all childs of a category
  test "get childs of a category" do
    # find category with name is IT
    parent = Category.find_by(category_name: 'IT');
    assert_not parent.nil?

    #find child of category IT
    results = Array.new

    childs = Category.any_in(parent_ids: [parent.id])
    childs.each do |child|
      results << child
      puts child.category_name
    end
    assert_equal results.size, 2
  end


  test "get childs of category" do
    category_id = '5460cc68487579177c1e0000'

    childs = Category.get_childs_of_category(category_id)

    childs.each do |child|
      puts child.category_name
    end
  end

  test "find categories with id in array" do
    categories = Category.where(category_name: /IT/)
    results = Array.new
    categories.each do |category|
      results << category
    end

    categories = Category.any_in(id: results)
    categories.each do |category|
      puts category.category_name
    end
  end

  test "create a category have level" do
    category = Category.new
    category.category_name = 'IT'
    assert category.save

    assert Level.create(level_name: 'level IT 1', level_order: 1, category_id: category.id)
    assert Level.create(level_name: 'level IT 2', level_order: 2, category_id: category.id)
    assert Level.create(level_name: 'level IT 3', level_order: 3, category_id: category.id)
  end

  test "get all categories with hierachy" do
    Category.get_all_categories.each do |category|
      puts category.category_name
    end
  end

  test "times " do
    str = 'asfjasdf'
    stra = 4.times.collect {'text'}.join(str)
    puts stra
  end

  test "find hierachy category" do

    categories = Category.where(category_name: /IT/)

    categories.each do |category|
      if category.parent_ids && category.parent_ids.size > 0
        prefix = ''
        category.parent_ids.size.times do
          prefix = prefix + '&nbsp;&nbsp;&nbsp;'
        end
        category.category_name = (prefix + category.category_name).html_safe
        puts category.category_name
      end
    end
  end
end