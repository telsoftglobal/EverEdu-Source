require 'test_helper'

class CurriculumTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "create data test" do
    categories = Category.where(category_name: 'IT')
    categories.each do |category|
      #create 10 curriculum for one category
      curriculum_count = 0
      while curriculum_count < 20 do
        curriculum_count = curriculum_count + 1
        curriculum = Curriculum.new
        name = "curriculum #{curriculum_count} #{category.category_name}"
        curriculum.curriculum_name = name
        curriculum.summary = "summary of #{name}"
        curriculum.description = "description of #{name}"
        curriculum.mentor = User.find_by(user_name: 'huyendt')

        curriculum.curriculum_categories = Array.new

        level_ids = Array.new
        level_ids << Level.find_by(category_id: category.id, level_order: 1).id
        level_ids << Level.find_by(category_id: category.id, level_order: 2).id

        cc1 = CurriculumCategory.new(category_id: category.id, category_name: category.category_name, level_ids: level_ids)
        curriculum.curriculum_categories << cc1

        subcategory = Category.find_by(show_priority: 1 + Random.rand(50))
        if subcategory != category
          level_ids = Array.new
          level_ids << Level.find_by(category_id: subcategory.id, level_order: 3).id
          level_ids << Level.find_by(category_id: subcategory.id, level_order: 4).id

          cc2 = CurriculumCategory.new(category_id: subcategory.id, category_name: subcategory.category_name, level_ids: level_ids)
          curriculum.curriculum_categories << cc2
        end


        assert curriculum.save

        #materials
        material_count = 0
        while material_count < 1 do
          material_count = material_count + 1
          material = Material.new
          material.curriculum = curriculum
          material.material_name = "material #{material_count} of #{name}"
          material.material_type = MaterialType.find_by(show_priority: 1 + Random.rand(3))
          material.material_url = 'http://'
          material.description = "description of #{material.material_name}"
          assert material.save
        end

        #actions
        action_count = 0
        while action_count < 1 do
          action_count = action_count + 1
          action = Action.new
          action.curriculum = curriculum
          action.action_name = "action #{action_count} of #{name}"
          action.description = "description of #{action.action_name}"
          assert action.save
        end
      end
    end
  end

  test "create a curriculum with curriculum name have special characters" do
    curriculum = Curriculum.new
    curriculum.curriculum_name = 'curriculum special character +.~!@#$%^&*()[]{}\/|<> -_;=,.\'\"'
    curriculum.summary = 'summary of curriculum1 '
    curriculum.description
    curriculum.mentor_id = User.find_by(user_name: 'huyendt').id

    category = Category.find_by(category_name: /IT/)
    curriculum.curriculum_categories = Array.new
    level_ids = Array.new
    level_ids << Level.find_by(category_id: category.id, level_order: 1).id
    level_ids << Level.find_by(category_id: category.id, level_order: 2).id

    cc1 = CurriculumCategory.new(category_id: category.id, category_name: category.category_name, level_ids: level_ids)
    curriculum.curriculum_categories << cc1
    assert curriculum.save


  end

  test "create a curriculum with general information" do
    curriculum = Curriculum.new
    curriculum.curriculum_name = 'curriculum1'
    curriculum.summary = 'summary of curriculum1'
    curriculum.duration = 1
    curriculum.unit = Unit.find_by(id: 'week')
    curriculum.category = Category.find_by(category_name: 'IT')
    curriculum.start_date = Date.new
    curriculum.end_date = Date.new + 10
    curriculum.description = 'description of curriculum1'
    curriculum.mentor = User.find_by(user_name: 'huyendt')

    assert curriculum.save

    #curriculum.materials << Material.new(name: '1')
    #curriculum.materials << Material.new(name: '2')
  end

  test "create a curriculum with materials and actions" do
    #curriculum
    curriculum = Curriculum.new
    curriculum.curriculum_name = 'curriculum2'
    curriculum.summary = 'summary of curriculum2'
    curriculum.duration = 1
    curriculum.unit = Unit.find_by(id: 'week')
    curriculum.start_date = Date.new
    curriculum.end_date = Date.new + 10
    curriculum.description = 'description of curriculum2'
    curriculum.mentor = User.find_by(user_name: 'huyendt')

    assert curriculum.save

    #materials
    material1 = Material.new
    material1.curriculum = curriculum
    material1.material_name = 'material1 of curriculum2'
    material1.material_type = MaterialType.find_by(material_type_name: 'book')
    material1.material_url = 'http://'
    material1.duration = 1
    material1.unit = Unit.find_by(id: 'hour')
    material1.description = 'description of material 1 of curriculum2'
    assert material1.save

    material2 = Material.new
    material2.curriculum = curriculum
    material2.material_name = 'material2 of curriculum2'
    material2.material_type = MaterialType.find_by(material_type_name: 'video')
    material2.material_url = 'http://'
    material2.duration = 1
    material2.unit = Unit.find_by(id: 'hour')
    material2.description = 'description of material 2 of curriculum2'
    assert material2.save

    #actions
    action = Action.new
    action.curriculum = curriculum
    action.action_name = 'action1 of curriculum2'
    action.description = 'description of action1 of curriculum2'
    assert action.save
  end

  test "search curriculum with category_ids and name" do
    keyword = 'Curriculum'
    categories = Category.where(category_name: /IT/)
    category_ids = Array.new
    categories.each do |category|
      category_ids << category.id
    end

    curriculums = Curriculum.any_in(category_id: category_ids).and(curriculum_name: /#{keyword}/i, status: 1).order_by(curriculum_name: 1, created_at: 1)
    curriculums.each do |curriculum|
      puts curriculum.curriculum_name
    end

    puts curriculums.size
  end

  test "search curriculum" do
    category = Category.where(category_name: /IT/).first
    #curriculums = Curriculum.where("curriculum_categories.category_id" => 'ObjectId("54648bfe48757936148c0100")', curriculum_name: /curriculum/i, status: 1, mentor_id: 'ObjectId("5449dbc748757910f0070000")').order_by(created_at: -1, curriculum_name: 1)
    curriculums = Curriculum.where("curriculum_categories.category_id" => BSON::ObjectId.from_string("54648bfe48757936148c0100"), curriculum_name: /curriculum/i, status: 1).order_by(created_at: -1, curriculum_name: 1)
    curriculums.each do |curriculum|
      puts curriculum.curriculum_name
    end
  end

  test "create tree material" do
    curriculum = Curriculum.new(curriculum_name: 'TEST TREE', summary: 'TEST', description: 'TEST', status: 1)
    curriculum.mentor_id = User.find_by(user_name: 'huyendt').id
    curriculum.curriculum_categories = Array.new

    category = Category.find_by(category_name: 'IT')
    level_ids = Array.new
    level_ids << Level.find_by(category_id: category.id, level_order: 1).id
    level_ids << Level.find_by(category_id: category.id, level_order: 2).id

    cc1 = CurriculumCategory.new(category_id: category.id, category_name: category.category_name, level_ids: level_ids)
    curriculum.curriculum_categories << cc1
    assert curriculum.save

    material = Material.new(material_name: 'material 1', curriculum_id: curriculum.id)
    assert material.save

    material1 = Material.new(material_name: 'material 1', curriculum_id: curriculum.id)
    material1.parent = material
    assert material1.save

    material2 = Material.new(material_name: 'material 2', curriculum_id: curriculum.id)
    material2.parent = material
    assert material2.save
  end

  test "create tree material 2 level" do
    curriculum = Curriculum.new(curriculum_name: 'TEST TREE 2 level', summary: 'TEST', description: 'TEST', status: 1)
    curriculum.mentor_id = User.find_by(user_name: 'huyendt').id
    curriculum.curriculum_categories = Array.new

    category = Category.find_by(category_name: 'IT')
    level_ids = Array.new
    level_ids << Level.find_by(category_id: category.id, level_order: 1).id
    level_ids << Level.find_by(category_id: category.id, level_order: 2).id

    cc1 = CurriculumCategory.new(category_id: category.id, category_name: category.category_name, level_ids: level_ids)
    curriculum.curriculum_categories << cc1
    assert curriculum.save


    material_1 = Material.new(material_name: 'material 1 TEST TREE 2 level', curriculum_id: curriculum.id)
    assert material_1.save

    material = Material.new(material_name: 'material 2 TEST TREE 2 level', curriculum_id: curriculum.id)
    assert material.save

    material1 = Material.new(material_name: 'material 2.1', curriculum_id: curriculum.id)
    material1.parent = material
    assert material1.save

    material2 = Material.new(material_name: 'material 2.2', curriculum_id: curriculum.id)
    material2.parent = material
    assert material2.save

    material221 = Material.new(material_name: 'material 2.2.1', curriculum_id: curriculum.id)
    material221.parent = material2
    assert material221.save

    material222 = Material.new(material_name: 'material 2.2.2', curriculum_id: curriculum.id)
    material222.parent = material2
    assert material222.save


  end


  test "search tree material" do
    curriculum = Curriculum.find_by(curriculum_name: 'TEST TREE')

    materials = Material.where(parent_id: nil, curriculum_id: curriculum.id)
    materials.each do |material|
      puts "parent material #{material.id}"
      material.children.each do |child|
        puts "child material #{child.id}"
      end
    end


  end

  test "search tree material level 2" do
    curriculum = Curriculum.find_by(curriculum_name: 'TEST TREE')

    materials = Material.where(parent_id: nil, curriculum_id: curriculum.id)
    materials.each do |material|
      puts "parent material #{material.id}"
      material.children.each do |child|
        puts "child material #{child.id}"

      end
    end
  end

  test "create material tree with embed" do
    curriculum = Curriculum.new(curriculum_name: 'TEST TREE 3 level', summary: 'TEST', description: 'TEST', status: 1)
    assert curriculum.save

    material1 = Material.new(material_name: 'material 1 TEST TREE 3 level', curriculum_id: curriculum.id)


    material11 = material1.child_materials.build(material_name: 'material 1.1 TEST TREE 3 level', curriculum_id: curriculum.id)

    material12 = material1.child_materials.build(material_name: 'material 1.2 TEST TREE 3 level', curriculum_id: curriculum.id)


    material11.child_materials.build(material_name: 'material 1.1.1 TEST TREE 3 level', curriculum_id: curriculum.id)
    material11.child_materials.build(material_name: 'material 1.1.2 TEST TREE 3 level', curriculum_id: curriculum.id)

    assert material1.save
  end

  test "filter curriculum with category_id, level_id and curriculum_name" do
    category = Category.find_by(category_name: /IT/)
    level = Level.find_by(category_id: category.id, level_order: 2)
    name = ''

    query = Curriculum.where('curriculum_categories.category_id' => category.id)
    if !level.nil?
      query = query.any_in('curriculum_categories.level_ids' => level.id)
    end

    if !name.blank?
      query = query.and(curriculum_name: /#{name}/i)
    end

    curriculums = query.order_by(created_at: -1, curriculum_name: 1)

    curriculums.each do |curriculum|
      puts (curriculum.curriculum_name + ' ' + curriculum.id)
    end
  end

  # @author: HuyenDT
  test "search by category_id, level_id, name and paging" do
    # test data
    category = Category.find_by(category_name: /IT/)
    level = Level.find_by(category_id: category.id, level_order: 2)
    name = 'curriculum'
    page_number = 1
    item_per_page = 10

    #call search method of Curriculum
    result = Curriculum.search(category.id, level.id, name, page_number, item_per_page)

    #expected result
    expected_result = Curriculum.where('curriculum_categories.category_id' => category.id).any_in('curriculum_categories.level_ids' => level.id).and(curriculum_name: /#{name}/i).order_by(created_at: -1, curriculum_name: 1).skip((page_number - 1) * item_per_page).limit(item_per_page)

    puts "*** RESULT ***"
    result.each do |r|
      puts r.id
    end

    puts "*** EXPECTED RESULT ***"
    expected_result.each do |r|
      puts r.id
    end
    #compare result and expected result
    assert (result == expected_result)

  end

  test 'edit curriculum' do
    curriculum_name = "Test join 1 updated updated updated"
    curriculum = Curriculum.find_by(curriculum_name: curriculum_name)
    assert_not curriculum.nil?

    curriculum_update = Curriculum.new
    curriculum_update.id = curriculum.id
    curriculum_update.curriculum_name = curriculum_name
    curriculum_update.summary = 'summary'
    curriculum_update.new_record = false

    #update material
    materials_update = Array.new
    curriculum.materials.each do |material|
      material_update = Material.new
      material_update.id = material.id
      material_update.material_name = material.material_name + ' updated'
      material_update.curriculum = curriculum_update
      material_update.new_record = false
      materials_update << material_update
    end

    materialnew1 = Material.new
    materialnew1.material_name = 'material new 1'
    materialnew1.curriculum = curriculum_update
    materials_update << materialnew1

    materialnew2 = Material.new
    materialnew2.material_name = 'material new 2'
    materialnew2.curriculum = curriculum_update
    materialnew2.parent = materialnew1
    materials_update << materialnew2



    curriculum_update.materials = materials_update

    #update action
    actions_update = Array.new
    curriculum.actions.each do |action|
      action_update = Action.new
      action_update.id = action.id
      action_update.action_name = action.action_name + ' updated'
      action_update.curriculum = curriculum_update
      action_update.new_record = false
      actions_update << action_update
    end
    curriculum_update.actions = actions_update

     curriculum_update.save

    # curriculum_update.materials.each do |material|
    #   assert material.save
    # end
    #
    # curriculum_update.actions.each do |action|
    #   assert action.save
    # end


    curriculum = Curriculum.new
    curriculum.materials = []
    curriculum.save
    #curriculum.materials << material1


    material1 = Material.new
    material1.name='1'
    material1.curriculum = curriculum
    curriculum.materials << material1
    material1.save


  end


  #=============================CUONGCT CREATE CURRICULUM=====================================================
  #Create success
  test 'Create curriculum success all field' do
    curriculum = Curriculum.new
    curriculum.curriculum_name = 'This is curriculum name'
    curriculum.summary = 'This is summarry'
    curriculum.description = 'This is description'

    mentor_name = 'cuongct'
    curriculum.mentor_id = User.find_by(user_name: mentor_name)

    #material 1
    material1 = Material.new
    material1.material_name = 'This is material1 name'
    material1.material_url = 'http://telsoft.com.vn'
    material1.description = 'This is material1 description'
    material1.status = 1
    material1.material_type = MaterialType.first
      #material 2
      material2 = Material.new
      material2.material_name = 'This is material2 name'
      material2.material_url = 'This is material2 url'
      material2.description = 'This is material2 description'
      material2.status = 1
      material2.material_type = MaterialType.first
      material2.parent=material1
    #material 3
    material3 = Material.new
    material3.material_name = 'This is material2 name'
    material3.material_url = 'This is material2 url'
    material3.description = 'This is material2 description'
    material3.status = 1
    material3.material_type = MaterialType.first

    curriculum.materials << material1
    curriculum.materials << material2
    curriculum.materials << material3

    action = Action.new
    action.action_name = 'this is Action name'
    action.description = 'this is Action description'
    curriculum.actions << action


    category = Category.first

    curriculum_category = CurriculumCategory.new
    curriculum_category.category = category
    curriculum_category.category_name = category.category_name
    curriculum_category.level_ids << category.levels[0].id
    curriculum_category.level_ids << category.levels[3].id
    curriculum_category.level_ids << category.levels[4].id
    curriculum.curriculum_categories = Array.new
    curriculum.curriculum_categories << curriculum_category

    curriculum.save
    # curriculum.errors.each do |mess|
    #   puts mess
    # end
  end

  test 'Create curriculum success have one material' do
    curriculum = Curriculum.new
    curriculum.curriculum_name = 'This is curriculum name'
    curriculum.summary = 'This is summarry'
    curriculum.description = 'This is description'

    mentor_name = 'cuongct'
    curriculum.mentor_id = User.find_by(user_name: mentor_name)

    #material 1

    #material 2
    material1 = Material.new
    material1.material_name = 'This is material2 name'
    material1.material_url = 'This is material2 url'
    material1.description = 'This is material2 description'
    material1.material_type = MaterialType.first

    curriculum.materials << material1

    action = Action.new
    action.action_name = 'this is Action name'
    action.description = 'this is Action description'
    curriculum.actions << action

    category = Category.first
    curriculum_category = CurriculumCategory.new
    curriculum_category.category = category
    curriculum_category.category_name = category.category_name
    curriculum_category.level_ids << category.levels[0].id
    curriculum_category.level_ids << category.levels[3].id
    curriculum_category.level_ids << category.levels[4].id
    curriculum.curriculum_categories = Array.new
    curriculum.curriculum_categories << curriculum_category

    curriculum.save

  end

  test 'Create curriculum success have one action' do
    curriculum = Curriculum.new
    curriculum.curriculum_name = 'This is curriculum name'
    curriculum.summary = 'This is summarry'
    curriculum.description = 'This is description'

    mentor_name = 'cuongct'
    curriculum.mentor_id = User.find_by(user_name: mentor_name)

    #material 1

    #material 2
    material1 = Material.new
    material1.material_name = 'This is material2 name'
    material1.material_url = 'This is material2 url'
    material1.description = 'This is material2 description'
    material1.material_type = MaterialType.first

    curriculum.materials << material1

    action = Action.new
    action.action_name = 'this is Action name'
    action.description = 'this is Action description'
    curriculum.actions << action

    category = Category.first
    curriculum_category = CurriculumCategory.new
    curriculum_category.category = category
    curriculum_category.category_name = category.category_name
    curriculum_category.level_ids << category.levels[0].id
    curriculum_category.level_ids << category.levels[3].id
    curriculum_category.level_ids << category.levels[4].id
    curriculum.curriculum_categories = Array.new
    curriculum.curriculum_categories << curriculum_category

    assert_not curriculum.save
  end

  test 'Create curriculum success have one category' do
    curriculum = Curriculum.new
    curriculum.curriculum_name = 'This is curriculum name'
    curriculum.summary = 'This is summarry'
    curriculum.description = 'This is description'

    mentor_name = 'cuongct'
    curriculum.mentor_id = User.find_by(user_name: mentor_name)

    #material 1

    #material 2
    material1 = Material.new
    material1.material_name = 'This is material2 name'
    material1.material_url = 'This is material2 url'
    material1.description = 'This is material2 description'
    material1.material_type = MaterialType.first

    curriculum.materials << material1

    action = Action.new
    action.action_name = 'this is Action name'
    action.description = 'this is Action description'
    curriculum.actions << action

    category = Category.first
    curriculum_category = CurriculumCategory.new
    curriculum_category.category = category
    curriculum_category.category_name = category.category_name
    curriculum_category.level_ids << category.levels[0].id
    curriculum_category.level_ids << category.levels[3].id
    curriculum_category.level_ids << category.levels[4].id
    curriculum.curriculum_categories = Array.new
    curriculum.curriculum_categories << curriculum_category

    curriculum.save
  end


#Create failed
  test 'Create curriculum empty all filed' do
    curriculum = Curriculum.new
    assert_not curriculum.save
    curriculum.errors.full_messages.each do |mess|
      puts mess
    end
  end

  test 'Create curriculum empty curriculum name filed' do
    curriculum = Curriculum.new

    mentor_name = 'cuongct'
    curriculum.mentor_id = User.find_by(user_name: mentor_name)

    assert_not curriculum.save
    curriculum.errors.full_messages.each do |mess|
      puts mess
    end
  end

  test 'Create curriculum empty curriculum summary filed' do
    curriculum = Curriculum.new
    curriculum.curriculum_name = 'This is curriculum name'

    mentor_name = 'cuongct'
    curriculum.mentor_id = User.find_by(user_name: mentor_name)

    assert_not curriculum.save
    curriculum.errors.full_messages.each do |mess|
      puts mess
    end
  end

  test 'Create curriculum not have material ' do
    curriculum = Curriculum.new
    curriculum.curriculum_name = 'This is curriculum name'
    curriculum.summary = 'This is summarry'
    curriculum.description = 'This is description'

    mentor_name = 'cuongct'
    curriculum.mentor_id = User.find_by(user_name: mentor_name)



    action = Action.new
    action.action_name = 'this is Action name'
    action.description = 'this is Action description'
    curriculum.actions << action

    category = Category.first
    curriculum_category = CurriculumCategory.new
    curriculum_category.category = category
    curriculum_category.category_name = category.category_name
    curriculum_category.level_ids << category.levels[0].id
    curriculum_category.level_ids << category.levels[3].id
    curriculum_category.level_ids << category.levels[4].id
    curriculum.curriculum_categories = Array.new
    curriculum.curriculum_categories << curriculum_category

    curriculum.save

  end

  test 'Create curriculum not have category ' do
    curriculum = Curriculum.new
    curriculum.curriculum_name = 'This is curriculum name'
    curriculum.summary = 'This is summarry'
    curriculum.description = 'This is description'

    mentor_name = 'cuongct'
    curriculum.mentor_id = User.find_by(user_name: mentor_name)

    #material 1
    material1 = Material.new
    material1.material_name = 'This is material1 name'
    material1.material_url = 'http://telsoft.com.vn'
    material1.description = 'This is material1 description'
    material1.status = 1
    material1.material_type = MaterialType.first

    curriculum.materials << material1

    curriculum.save
    # curriculum.errors.full_messages.each do |mess|
    #   puts mess
    # end
  end

  test 'Create curriculum max length name ' do
    curriculum = Curriculum.new
    curriculum.curriculum_name = '1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|'
    curriculum.summary = 'This is summarry'
    curriculum.description = 'This is description'

    mentor_name = 'cuongct'
    curriculum.mentor_id = User.find_by(user_name: mentor_name)

    #material 1
    material1 = Material.new
    material1.material_name = 'This is material1 name'
    material1.material_url = 'http://telsoft.com.vn'
    material1.description = 'This is material1 description'
    material1.status = 1
    material1.material_type = MaterialType.first

    curriculum.materials << material1
    category = Category.first

    curriculum_category = CurriculumCategory.new
    curriculum_category.category = category
    curriculum_category.category_name = category.category_name
    curriculum_category.level_ids << category.levels[0].id
    curriculum_category.level_ids << category.levels[3].id
    curriculum_category.level_ids << category.levels[4].id
    curriculum.curriculum_categories = Array.new
    curriculum.curriculum_categories << curriculum_category

    assert_not curriculum.save
    curriculum.errors.full_messages.each do |mess|
      puts mess
    end
  end

  test 'Create curriculum max length summary ' do
    curriculum = Curriculum.new
    curriculum.curriculum_name = 'This is curriculum name'
    curriculum.summary = '1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|'
    curriculum.description = 'This is description'

    mentor_name = 'cuongct'
    curriculum.mentor_id = User.find_by(user_name: mentor_name)

    #material 1
    material1 = Material.new
    material1.material_name = 'This is material1 name'
    material1.material_url = 'http://telsoft.com.vn'
    material1.description = 'This is material1 description'
    material1.status = 1
    material1.material_type = MaterialType.first

    curriculum.materials << material1
    category = Category.first

    curriculum_category = CurriculumCategory.new
    curriculum_category.category = category
    curriculum_category.category_name = category.category_name
    curriculum_category.level_ids << category.levels[0].id
    curriculum_category.level_ids << category.levels[3].id
    curriculum_category.level_ids << category.levels[4].id
    curriculum.curriculum_categories = Array.new
    curriculum.curriculum_categories << curriculum_category

    curriculum.save

    curriculum.errors.full_messages.each do |mess|
      puts mess
    end

  end

  test 'Create curriculum max length action name ' do
    curriculum = Curriculum.new
    curriculum.curriculum_name = 'This is curriculum name'
    curriculum.summary = 'This is curriculum summary'
    curriculum.description = 'This is description'

    mentor_name = 'cuongct'
    curriculum.mentor_id = User.find_by(user_name: mentor_name)

    #material 1
    material1 = Material.new
    material1.material_name = 'This is material1 name'
    material1.material_url = 'http://telsoft.com.vn'
    material1.description = 'This is material1 description'
    material1.status = 1
    material1.material_type = MaterialType.first

    action = Action.new
    action.action_name = '1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|'
    action.description = 'this is Action description'
    curriculum.actions << action

    curriculum.materials << material1
    category = Category.first

    curriculum_category = CurriculumCategory.new
    curriculum_category.category = category
    curriculum_category.category_name = category.category_name
    curriculum_category.level_ids << category.levels[0].id
    curriculum_category.level_ids << category.levels[3].id
    curriculum_category.level_ids << category.levels[4].id
    curriculum.curriculum_categories = Array.new
    curriculum.curriculum_categories << curriculum_category

    curriculum.save

    curriculum.errors.full_messages.each do |mess|
      puts mess
    end

  end

  # empty name
  test 'Create curriculum empty name ' do
    curriculum = Curriculum.new
    curriculum.curriculum_name = ''
    curriculum.summary = 'This is summary'
    curriculum.description = 'This is description'

    mentor_name = 'cuongct'
    curriculum.mentor_id = User.find_by(user_name: mentor_name)

    #material 1
    material1 = Material.new
    material1.material_name = 'This is material1 name'
    material1.material_url = 'http://telsoft.com.vn'
    material1.description = 'This is material1 description'
    material1.status = 1
    material1.material_type = MaterialType.first

    curriculum.materials << material1
    category = Category.first

    curriculum_category = CurriculumCategory.new
    curriculum_category.category = category
    curriculum_category.category_name = category.category_name
    curriculum_category.level_ids << category.levels[0].id
    curriculum_category.level_ids << category.levels[3].id
    curriculum_category.level_ids << category.levels[4].id
    curriculum.curriculum_categories = Array.new
    curriculum.curriculum_categories << curriculum_category

    assert_not curriculum.save
    curriculum.errors.full_messages.each do |mess|
      puts mess
    end
  end

  test 'Create curriculum empty summary ' do
    curriculum = Curriculum.new
    curriculum.curriculum_name = 'This is curriculum name'
    curriculum.summary = ''
    curriculum.description = 'This is description'

    mentor_name = 'cuongct'
    curriculum.mentor_id = User.find_by(user_name: mentor_name)
    
    #material 1
    material1 = Material.new
    material1.material_name = 'This is material1 name'
    material1.material_url = 'http://telsoft.com.vn'
    material1.description = 'This is material1 description'
    material1.status = 1
    material1.material_type = MaterialType.first

    curriculum.materials << material1
    category = Category.first

    curriculum_category = CurriculumCategory.new
    curriculum_category.category = category
    curriculum_category.category_name = category.category_name
    curriculum_category.level_ids << category.levels[0].id
    curriculum_category.level_ids << category.levels[3].id
    curriculum_category.level_ids << category.levels[4].id
    curriculum.curriculum_categories = Array.new
    curriculum.curriculum_categories << curriculum_category

    curriculum.save

    curriculum.errors.full_messages.each do |mess|
      puts mess
    end

  end

  test 'Create curriculum empty material' do
    curriculum = Curriculum.new
    curriculum.curriculum_name = 'This is curriculum name'
    curriculum.summary = 'This is curriculum summary'
    curriculum.description = 'This is description'

    mentor_name = 'cuongct'
    curriculum.mentor_id = User.find_by(user_name: mentor_name)
    
    action = Action.new
    action.action_name = 'This is action name'
    action.description = 'this is Action description'
    curriculum.actions << action

    category = Category.first

    curriculum_category = CurriculumCategory.new
    curriculum_category.category = category
    curriculum_category.category_name = category.category_name
    curriculum_category.level_ids << category.levels[0].id
    curriculum_category.level_ids << category.levels[3].id
    curriculum_category.level_ids << category.levels[4].id
    curriculum.curriculum_categories = Array.new
    curriculum.curriculum_categories << curriculum_category

    curriculum.save

    curriculum.errors.full_messages.each do |mess|
      puts mess
    end

  end

  test 'Create curriculum empty material name ' do
    curriculum = Curriculum.new
    curriculum.curriculum_name = 'This is curriculum name'
    curriculum.summary = 'This is curriculum summary'
    curriculum.description = 'This is description'

    mentor_name = 'cuongct'
    curriculum.mentor_id = User.find_by(user_name: mentor_name)

    #material 1
    material1 = Material.new
    material1.material_name = ''
    material1.material_url = 'http://telsoft.com.vn'
    material1.description = 'This is material1 description'
    material1.status = 1
    material1.material_type = MaterialType.first

    action = Action.new
    action.action_name = 'This is action name'
    action.description = 'this is Action description'
    curriculum.actions << action

    curriculum.materials << material1
    category = Category.first

    curriculum_category = CurriculumCategory.new
    curriculum_category.category = category
    curriculum_category.category_name = category.category_name
    curriculum_category.level_ids << category.levels[0].id
    curriculum_category.level_ids << category.levels[3].id
    curriculum_category.level_ids << category.levels[4].id
    curriculum.curriculum_categories = Array.new
    curriculum.curriculum_categories << curriculum_category

    curriculum.save

    curriculum.errors.full_messages.each do |mess|
      puts mess
    end

  end

  test 'Create curriculum empty action name ' do

    
    curriculum = Curriculum.new
    curriculum.curriculum_name = 'This is curriculum name'
    curriculum.summary = 'This is curriculum summary'
    curriculum.description = 'This is description'
    
    mentor_name = 'cuongct'
    curriculum.mentor_id = User.find_by(user_name: mentor_name)
    
    #material 1
    material1 = Material.new
    material1.material_name = 'This is material1 name'
    material1.material_url = 'http://telsoft.com.vn'
    material1.description = 'This is material1 description'
    material1.status = 1
    material1.material_type = MaterialType.first

    action = Action.new
    action.action_name = ''
    action.description = 'this is Action description'
    curriculum.actions << action

    curriculum.materials << material1
    category = Category.first

    curriculum_category = CurriculumCategory.new
    curriculum_category.category = category
    curriculum_category.category_name = category.category_name
    curriculum_category.level_ids << category.levels[0].id
    curriculum_category.level_ids << category.levels[3].id
    curriculum_category.level_ids << category.levels[4].id
    curriculum.curriculum_categories = Array.new
    curriculum.curriculum_categories << curriculum_category

    curriculum.save

    curriculum.errors.full_messages.each do |mess|
      puts mess
    end

  end

  #Url format
  test 'Create curriculum wrong url format ' do


    curriculum = Curriculum.new
    curriculum.curriculum_name = 'This is curriculum name'
    curriculum.summary = 'This is curriculum summary'
    curriculum.description = 'This is description'

    mentor_name = 'cuongct'
    curriculum.mentor_id = User.find_by(user_name: mentor_name)

    #material 1
    material1 = Material.new
    material1.material_name = 'This is material1 name'
    material1.material_url = 'telsoft.com.vn'
    material1.description = 'This is material1 description'
    material1.status = 1
    material1.material_type = MaterialType.first

    action = Action.new
    action.action_name = 'Action name'
    action.description = 'this is Action description'
    curriculum.actions << action

    curriculum.materials << material1
    category = Category.first

    curriculum_category = CurriculumCategory.new
    curriculum_category.category = category
    curriculum_category.category_name = category.category_name
    curriculum_category.level_ids << category.levels[0].id
    curriculum_category.level_ids << category.levels[3].id
    curriculum_category.level_ids << category.levels[4].id
    curriculum.curriculum_categories = Array.new
    curriculum.curriculum_categories << curriculum_category

    curriculum.save

    curriculum.errors.full_messages.each do |mess|
      puts mess
    end

  end


  #====================================UPDATE CURRICULUM SUCESS ====================================

  test 'Update curriculum all info' do
    time = Time.now
    # curriculum = Curriculum.find_by(:id =>BSON::ObjectId.from_string('547c219d43756f53c20b0000'))
    curriculum = Curriculum.first
    strTime =time.strftime(" edit: %m/%d/%Y %I:%M%p")
    if !curriculum.nil?

      curriculum.materials.each do |material|
        material.update(:material_name => 'material.material_name' + strTime, :description => 'material.description' + strTime)
      end

      curriculum.actions.each do |action|
        action.update(:action_name => 'action.action_name' + strTime, :description => 'action.description' + strTime)
      end
      category = Category.first

      curriculum_category = CurriculumCategory.new
      curriculum_category.category = category
      curriculum_category.category_name = category.category_name
      curriculum_category.level_ids << category.levels[0].id
      curriculum_category.level_ids << category.levels[3].id
      curriculum_category.level_ids << category.levels[4].id
      curriculum.curriculum_categories << curriculum_category

      assert curriculum.update(:curriculum_name => 'update curriculum '+strTime,:summary => 'curriculum update '+strTime,:status => 'this is description update '+strTime)
      # curriculum = Curriculum.find_by(:id =>BSON::ObjectId.from_string('547c219d43756f53c20b0000'))
      curriculum = Curriculum.first
      curriculum.materials.each do |material|
        puts 'material Name: '+ material.material_name
        puts 'material Url: '+  material.material_url.to_s
        puts 'description: '+  material.description
        # puts material.material_name
      end


      puts '--------------Actions-----------------'
      curriculum.actions.each do |action|
        puts 'action Name: '+ action.action_name
        puts 'description: '+  action.description
        # puts material.material_name
      end

      puts '--------------Categories-----------------'
      curriculum.curriculum_categories.each do |category|
        puts 'Categories Name: '+ category.category_name
        puts '--------------List level-----------------'
        category.levels.each do |level|
          puts 'level: '+level.level_name
        end
        # puts material.material_name
      end
    else
      puts 'not found'
    end
  end

  test 'Update curriculum info' do
    time = Time.now
    # curriculum = Curriculum.find_by(:id =>BSON::ObjectId.from_string('547c219d43756f53c20b0000'))
    curriculum = Curriculum.first
    strTime =time.strftime(" edit: %m/%d/%Y %I:%M%p")
    if !curriculum.nil?

      assert curriculum.update(:curriculum_name => 'update curriculum '+strTime,:summary => 'curriculum update '+strTime,:status => 'this is description update '+strTime)
      curriculum = Curriculum.find_by(:id =>BSON::ObjectId.from_string('547c219d43756f53c20b0000'))

      curriculum.materials.each do |material|
        puts 'material Name: '+ material.material_name
        puts 'material Url: '+  material.material_url.to_s
        puts 'description: '+  material.description
        # puts material.material_name
      end


      puts '--------------Actions-----------------'
      curriculum.actions.each do |action|
        puts 'action Name: '+ action.action_name
        puts 'description: '+  action.description
        # puts material.material_name
      end

      puts '--------------Categories-----------------'
      curriculum.curriculum_categories.each do |category|
        puts 'Categories Name: '+ category.category_name
        puts '--------------List level-----------------'
        category.levels.each do |level|
          puts 'level: '+level.level_name
        end
        # puts material.material_name
      end

    else
      puts 'not found'
    end
  end

  test 'Update material info' do
    time = Time.now
    # curriculum = Curriculum.find_by(:id =>BSON::ObjectId.from_string('547c219d43756f53c20b0000'))
    curriculum = Curriculum.first
    strTime =time.strftime(" edit: %m/%d/%Y %I:%M%p")
    if !curriculum.nil?

      curriculum.materials.each do |material|
        material.update(:material_name => 'material.material_name' + strTime, :description => 'material.description' + strTime)
      end

      curriculum.materials.each do |material|
        puts 'material Name: '+ material.material_name
        puts 'material Url: '+  material.material_url.to_s
        puts 'description: '+  material.description
        # puts material.material_name
      end


      puts '--------------Actions-----------------'
      curriculum.actions.each do |action|
        puts 'action Name: '+ action.action_name
        puts 'description: '+  action.description
        # puts material.material_name
      end

      puts '--------------Categories-----------------'
      curriculum.curriculum_categories.each do |category|
        puts 'Categories Name: '+ category.category_name
        puts '--------------List level-----------------'
        category.levels.each do |level|
          puts 'level: '+level.level_name
        end
        # puts material.material_name
      end

    else
      puts 'not found'
    end
  end

  test 'Update action info' do
    time = Time.now
    # curriculum = Curriculum.find_by(:id =>BSON::ObjectId.from_string('547c219d43756f53c20b0000'))
    curriculum = Curriculum.first
    strTime =time.strftime(" edit: %m/%d/%Y %I:%M%p")
    if !curriculum.nil?


      curriculum.actions.each do |action|
        action.update(:action_name => 'action.action_name' + strTime, :description => 'action.description' + strTime)
      end



      curriculum.materials.each do |material|
        puts 'material Name: '+ material.material_name
        puts 'material Url: '+  material.material_url.to_s
        puts 'description: '+  material.description
        # puts material.material_name
      end


      puts '--------------Actions-----------------'
      curriculum.actions.each do |action|
        puts 'action Name: '+ action.action_name
        puts 'description: '+  action.description
        # puts material.material_name
      end

      puts '--------------Categories-----------------'
      curriculum.curriculum_categories.each do |category|
        puts 'Categories Name: '+ category.category_name
        puts '--------------List level-----------------'
        category.levels.each do |level|
          puts 'level: '+level.level_name
        end
        # puts material.material_name
      end

    else
      puts 'not found'
    end
  end


  test 'Update categories info' do
    time = Time.now
    # curriculum = Curriculum.find_by(:id =>BSON::ObjectId.from_string('547c219d43756f53c20b0000'))
    curriculum = Curriculum.first
    strTime =time.strftime(" edit: %m/%d/%Y %I:%M%p")
    if !curriculum.nil?

      category = Category.first
      curriculum_category = CurriculumCategory.new
      curriculum_category.category = category
      curriculum_category.category_name = category.category_name
      curriculum_category.level_ids = Array.new
      curriculum_category.level_ids << category.levels[0].id
      curriculum_category.level_ids << category.levels[3].id
      curriculum_category.level_ids << category.levels[4].id
      curriculum.curriculum_categories << curriculum_category




      curriculum.materials.each do |material|
        puts 'material Name: '+ material.material_name
        puts 'material Url: '+  material.material_url.to_s
        puts 'description: '+  material.description
        # puts material.material_name
      end


      puts '--------------Actions-----------------'
      curriculum.actions.each do |action|
        puts 'action Name: '+ action.action_name
        puts 'description: '+  action.description
        # puts material.material_name
      end

      puts '--------------Categories-----------------'
      curriculum.curriculum_categories.each do |category|
        puts 'Categories Name: '+ category.category_name
        puts '--------------List level-----------------'
        category.levels.each do |level|
          puts 'level: '+level.level_name
        end
        # puts material.material_name
      end

    else
      puts 'not found'
    end
  end

  #====================================UPDATE CURRICULUM FAILED ====================================


  test 'Update curriculum empty name' do
    time = Time.now
    # curriculum = Curriculum.find_by(:id =>BSON::ObjectId.from_string('547c219d43756f53c20b0000'))
    curriculum = Curriculum.first
    strTime =time.strftime(" edit: %m/%d/%Y %I:%M%p")
    if !curriculum.nil?

      curriculum.materials.each do |material|
        material.update(:material_name => 'material.name' + strTime, :description => 'material.description' + strTime)
      end

      curriculum.actions.each do |action|
        action.update(:action_name => 'action.action_name' + strTime, :description => 'action.description' + strTime)
      end
      category = Category.first

      curriculum_category = CurriculumCategory.new
      curriculum_category.category = category
      curriculum_category.category_name = category.category_name
      curriculum_category.level_ids << category.levels[0].id
      curriculum_category.level_ids << category.levels[3].id
      curriculum_category.level_ids << category.levels[4].id
      curriculum.curriculum_categories << curriculum_category

      curriculum.update(:curriculum_name => '',:summary => 'curriculum update '+strTime,:status => 'this is description update '+strTime)

       curriculum.errors.each do |message|
        puts message
      end
    else
      puts 'not found'
    end
  end


  test 'Update curriculum empty summary' do
    time = Time.now
    # curriculum = Curriculum.find_by(:id =>BSON::ObjectId.from_string('547c219d43756f53c20b0000'))
    curriculum = Curriculum.first
    strTime =time.strftime(" edit: %m/%d/%Y %I:%M%p")
    if !curriculum.nil?

      curriculum.materials.each do |material|
        material.update(:material_name => 'material.name' + strTime, :description => 'material.description' + strTime)
      end

      curriculum.actions.each do |action|
        action.update(:action_name => 'action.action_name' + strTime, :description => 'action.description' + strTime)
      end
      category = Category.first

      curriculum_category = CurriculumCategory.new
      curriculum_category.category = category
      curriculum_category.category_name = category.category_name
      curriculum_category.level_ids << category.levels[0].id
      curriculum_category.level_ids << category.levels[3].id
      curriculum_category.level_ids << category.levels[4].id
      curriculum.curriculum_categories << curriculum_category

      curriculum.update(:curriculum_name => 'this is curriculum name',:summary => '',:status => 'this is description update '+strTime)

      curriculum.errors.each do |message|
        puts message
      end
    else
      puts 'not found'
    end
  end


  test 'Update curriculum empty material name' do
    time = Time.now
    # curriculum = Curriculum.find_by(:id =>BSON::ObjectId.from_string('547c219d43756f53c20b0000'))
    curriculum = Curriculum.first
    strTime =time.strftime(" edit: %m/%d/%Y %I:%M%p")
    if !curriculum.nil?

      curriculum.materials.each do |material|
        material.update(:material_name => '', :description => 'material.description' + strTime)
      end

      curriculum.actions.each do |action|
        action.update(:action_name => 'action.action_name' + strTime, :description => 'action.description' + strTime)
      end
      category = Category.first

      curriculum_category = CurriculumCategory.new
      curriculum_category.category = category
      curriculum_category.category_name = category.category_name
      curriculum_category.level_ids << category.levels[0].id
      curriculum_category.level_ids << category.levels[3].id
      curriculum_category.level_ids << category.levels[4].id
      curriculum.curriculum_categories << curriculum_category

      curriculum.update(:curriculum_name => 'this is curriculum name'+ strTime,:summary => 'Summary'+ strTime,:status => 'this is description update '+strTime)

      curriculum.errors.each do |message|
        puts message
      end
    else
      puts 'not found'
    end
  end

  test 'Update curriculum empty action name' do
    time = Time.now
    # curriculum = Curriculum.find_by(:id =>BSON::ObjectId.from_string('547c219d43756f53c20b0000'))
    curriculum = Curriculum.first
    strTime =time.strftime(" edit: %m/%d/%Y %I:%M%p")
    if !curriculum.nil?

      curriculum.materials.each do |material|
        material.update(:material_name => 'Material name' + strTime, :description => 'material.description' + strTime)
      end

      curriculum.actions.each do |action|
        action.update(:action_name => '', :description => 'action.description' + strTime)
      end
      category = Category.first

      curriculum_category = CurriculumCategory.new
      curriculum_category.category = category
      curriculum_category.category_name = category.category_name
      curriculum_category.level_ids << category.levels[0].id
      curriculum_category.level_ids << category.levels[3].id
      curriculum_category.level_ids << category.levels[4].id
      curriculum.curriculum_categories << curriculum_category

      curriculum.update(:curriculum_name => 'this is curriculum name'+ strTime,:summary => 'Summary'+ strTime,:status => 'this is description update '+strTime)

      curriculum.errors.each do |message|
        puts message
      end
    else
      puts 'not found'
    end
  end

  test 'Update curriculum empty categories' do
    time = Time.now
    # curriculum = Curriculum.find_by(:id =>BSON::ObjectId.from_string('547c219d43756f53c20b0000'))
    curriculum = Curriculum.first
    strTime =time.strftime(" edit: %m/%d/%Y %I:%M%p")
    if !curriculum.nil?

      curriculum.curriculum_categories =[]

      curriculum.update(:curriculum_name => 'this is curriculum name'+ strTime,:summary => 'Summary'+ strTime,:status => 'this is description update '+strTime)

      curriculum.errors.each do |message|
        puts message
      end
    else
      puts 'not found'
    end
  end


  #===============================================max length==============================================
  test 'Update curriculum max name' do
    time = Time.now
    # curriculum = Curriculum.find_by(:id =>BSON::ObjectId.from_string('547c219d43756f53c20b0000'))
    curriculum = Curriculum.first
    strTime =time.strftime(" edit: %m/%d/%Y %I:%M%p")
    if !curriculum.nil?

      curriculum.materials.each do |material|
        material.update(:material_name => 'material.name' + strTime, :description => 'material.description' + strTime)
      end

      curriculum.actions.each do |action|
        action.update(:action_name => 'action.action_name' + strTime, :description => 'action.description' + strTime)
      end
      category = Category.first

      curriculum_category = CurriculumCategory.new
      curriculum_category.category = category
      curriculum_category.category_name = category.category_name
      curriculum_category.level_ids << category.levels[0].id
      curriculum_category.level_ids << category.levels[3].id
      curriculum_category.level_ids << category.levels[4].id
      curriculum.curriculum_categories << curriculum_category

      curriculum.update(:curriculum_name => '1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|',:summary => 'curriculum update '+strTime,:status => 'this is description update '+strTime)

      curriculum.errors.each do |message|
        puts message
      end
    else
      puts 'not found'
    end
  end


  test 'Update curriculum max summary' do
    time = Time.now
    # curriculum = Curriculum.find_by(:id =>BSON::ObjectId.from_string('547c219d43756f53c20b0000'))
    curriculum = Curriculum.first
    strTime =time.strftime(" edit: %m/%d/%Y %I:%M%p")
    if !curriculum.nil?

      curriculum.materials.each do |material|
        material.update(:material_name => 'material.name' + strTime, :description => 'material.description' + strTime)
      end

      curriculum.actions.each do |action|
        action.update(:action_name => 'action.action_name' + strTime, :description => 'action.description' + strTime)
      end
      category = Category.first

      curriculum_category = CurriculumCategory.new
      curriculum_category.category = category
      curriculum_category.category_name = category.category_name
      curriculum_category.level_ids << category.levels[0].id
      curriculum_category.level_ids << category.levels[3].id
      curriculum_category.level_ids << category.levels[4].id
      curriculum.curriculum_categories << curriculum_category

      curriculum.update(:curriculum_name => 'this is curriculum name',:summary => '1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|',:status => 'this is description update '+strTime)

      curriculum.errors.each do |message|
        puts message
      end
    else
      puts 'not found'
    end
  end


  test 'Update curriculum max material name' do
    time = Time.now
    # curriculum = Curriculum.find_by(:id =>BSON::ObjectId.from_string('547c219d43756f53c20b0000'))
    curriculum = Curriculum.first
    strTime =time.strftime(" edit: %m/%d/%Y %I:%M%p")
    if !curriculum.nil?

      curriculum.materials.each do |material|
        material.update(:material_name => '1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|', :description => 'material.description' + strTime)
      end

      curriculum.actions.each do |action|
        action.update(:action_name => 'action.action_name' + strTime, :description => 'action.description' + strTime)
      end
      category = Category.first

      curriculum_category = CurriculumCategory.new
      curriculum_category.category = category
      curriculum_category.category_name = category.category_name
      curriculum_category.level_ids << category.levels[0].id
      curriculum_category.level_ids << category.levels[3].id
      curriculum_category.level_ids << category.levels[4].id
      curriculum.curriculum_categories << curriculum_category

      curriculum.update(:curriculum_name => 'this is curriculum name'+ strTime,:summary => 'Summary'+ strTime,:status => 'this is description update '+strTime)

      curriculum.errors.each do |message|
        puts message
      end
    else
      puts 'not found'
    end
  end

  test 'Update curriculum max action name' do
    time = Time.now
    # curriculum = Curriculum.find_by(:id =>BSON::ObjectId.from_string('547c219d43756f53c20b0000'))
    curriculum = Curriculum.first
    strTime =time.strftime(" edit: %m/%d/%Y %I:%M%p")
    if !curriculum.nil?

      curriculum.materials.each do |material|
        material.update(:material_name => 'Material name' + strTime, :description => 'material.description' + strTime)
      end

      curriculum.actions.each do |action|
        action.update(:action_name => '1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|1234567890|', :description => 'action.description' + strTime)
      end
      category = Category.first

      curriculum_category = CurriculumCategory.new
      curriculum_category.category = category
      curriculum_category.category_name = category.category_name
      curriculum_category.level_ids << category.levels[0].id
      curriculum_category.level_ids << category.levels[3].id
      curriculum_category.level_ids << category.levels[4].id
      curriculum.curriculum_categories << curriculum_category

      curriculum.update(:curriculum_name => 'this is curriculum name'+ strTime,:summary => 'Summary'+ strTime,:status => 'this is description update '+strTime)

      curriculum.errors.each do |message|
        puts message
      end
    else
      puts 'not found'
    end
  end


  #===============URL FORMAT================================

  test 'Update curriculum url material format' do
    time = Time.now
    # curriculum = Curriculum.find_by(:id =>BSON::ObjectId.from_string('547c219d43756f53c20b0000'))
    curriculum = Curriculum.first
    strTime =time.strftime(" edit: %m/%d/%Y %I:%M%p")
    if !curriculum.nil?

      curriculum.materials.each do |material|
        material.update(:material_name => 'name',:url=>'fff', :description => 'material.description' + strTime)
      end

      curriculum.actions.each do |action|
        action.update(:action_name => 'action.action_name' + strTime, :description => 'action.description' + strTime)
      end
      category = Category.first

      curriculum_category = CurriculumCategory.new
      curriculum_category.category = category
      curriculum_category.category_name = category.category_name
      curriculum_category.level_ids << category.levels[0].id
      curriculum_category.level_ids << category.levels[3].id
      curriculum_category.level_ids << category.levels[4].id
      curriculum.curriculum_categories << curriculum_category

      curriculum.update(:curriculum_name => 'this is curriculum name'+ strTime,:summary => 'Summary'+ strTime,:status => 'this is description update '+strTime)

      curriculum.errors.each do |message|
        puts message
      end
    else
      puts 'not found'
    end
  end
end

